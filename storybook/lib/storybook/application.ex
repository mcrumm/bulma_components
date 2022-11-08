defmodule BulmaComponents.Storybook.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, [name: BulmaComponents.Storybook.PubSub]},
      BulmaComponents.Storybook.Endpoint
    ]

    opts = [strategy: :one_for_one, name: BulmaComponents.Storybook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BulmaComponents.Storybook.Endpoint.config_change(changed, removed)
    :ok
  end
end
