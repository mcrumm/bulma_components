import Config

config :phoenix, :json_library, Jason

config :dart_sass,
  version: "1.54.5",
  default: [
    args: ~w(--load-path=../deps/bulma css:../priv/static/assets),
    cd: Path.expand("../assets", __DIR__)
  ]

config :bulma_components_storybook, BulmaComponents.Storybook.Endpoint,
  url: [host: "localhost"],
  render_errors: [formats: [html: BulmaComponents.Storybook.ErrorHTML], layout: false],
  pubsub_server: BulmaComponents.Storybook.PubSub,
  live_view: [signing_salt: "iwVHqspHd6Y"]

import_config "#{config_env()}.exs"
