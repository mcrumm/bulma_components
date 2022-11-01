Application.put_env(:bulma_components, BulmaComponentsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hQCHben5qR5i+rq4v9wpLblgq53dhHVocqNWMdfvPifjNfadRs+lCll9iHr0wdP9",
  live_view: [signing_salt: "iwVHqspHd6Y"],
  http: [port: System.get_env("PORT") || 4000],
  render_errors: [formats: [html: BulmaComponentsWeb.ErrorHTML], layout: false],
  debug_errors: true,
  check_origin: false,
  pubsub_server: BulmaComponents.PubSub,
  watchers: [],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"storybook/.*(exs)$",
      ~r"lib/bulma_components/.*(ex)$"
    ]
  ]
)

Application.put_env(:phoenix, :json_library, Jason)

defmodule BulmaComponentsWeb.Storybook do
  use PhxLiveStorybook,
    otp_app: :bulma_components,
    content_path: Path.join([__DIR__, "storybook"]),
    sandbox_class: "bulma-components-web",
    title: "Bulma Components"
end

defmodule BulmaComponentsWeb.Router do
  use Phoenix.Router
  import PhxLiveStorybook.Router

  pipeline :browser do
    plug :fetch_session
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", BulmaComponentsWeb do
    pipe_through :browser
    live_storybook("/", backend_module: BulmaComponentsWeb.Storybook)
  end
end

defmodule BulmaComponentsWeb.ErrorHTML do
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end

defmodule BulmaComponentsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bulma_components

  socket "/live", Phoenix.LiveView.Socket
  socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket

  plug Phoenix.LiveReloader
  plug Phoenix.CodeReloader

  plug Plug.Session,
    store: :cookie,
    key: "_bulma_components_key",
    signing_salt: "3wG6v9qclWU"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug BulmaComponentsWeb.Router
end

Application.put_env(:phoenix, :serve_endpoints, true)

Task.async(fn ->
  children = [
    {Phoenix.PubSub, [name: BulmaComponents.PubSub]},
    BulmaComponentsWeb.Endpoint
  ]

  {:ok, _} = Supervisor.start_link(children, strategy: :one_for_one)
  Process.sleep(:infinity)
end)
|> Task.await(:infinity)
