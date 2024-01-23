defmodule Storybook2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Storybook2Web.Telemetry,
      {DNSCluster, query: Application.get_env(:storybook2, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Storybook2.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Storybook2.Finch},
      # Start a worker by calling: Storybook2.Worker.start_link(arg)
      # {Storybook2.Worker, arg},
      # Start to serve requests, typically the last entry
      Storybook2Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Storybook2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Storybook2Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
