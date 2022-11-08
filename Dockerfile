# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20220801-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.14.0-erlang-24.3.4.3-debian-bullseye-20220801-slim
#
ARG ELIXIR_VERSION=1.14.0
ARG OTP_VERSION=24.3.4.5
ARG DEBIAN_VERSION=bullseye-20220801-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# copy component dependencies
COPY mix.exs ./
COPY lib lib

# install mix dependencies
RUN mkdir -p storybook/config
COPY storybook/mix.exs storybook/mix.lock storybook/
RUN cd storybook && mix deps.get --only $MIX_ENV

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY storybook/config/config.exs storybook/config/${MIX_ENV}.exs storybook/config/
RUN cd storybook && mix deps.compile

COPY storybook/priv storybook/priv

COPY storybook/assets storybook/assets

# Compile the assets + the app
RUN cd storybook && mix assets.deploy && mix compile

# Note: changes to config/runtime.exs don't require recompiling the code
COPY storybook/config/runtime.exs storybook/config/

# Compile the release
COPY storybook/rel storybook/rel
RUN cd storybook && mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/storybook/_build/${MIX_ENV}/rel/bulma_components_storybook ./

USER nobody

CMD ["/app/bin/server"]