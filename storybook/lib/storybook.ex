defmodule BulmaComponents.Storybook do
  use PhxLiveStorybook,
    otp_app: :bulma_components_storybook,
    content_path: Path.expand("../storybook", __DIR__),
    css_path: "/assets/storybook.css",
    sandbox_class: "bulma-components-storybook",
    title: "Bulma Components"
end

defmodule BulmaComponents.Storybook.Router do
  use Phoenix.Router
  import PhxLiveStorybook.Router

  pipeline :browser do
    plug :fetch_session
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", BulmaComponents.Storybook do
    pipe_through :browser
    get "/", NextController, :storybook
    live_storybook("/storybook", backend_module: BulmaComponents.Storybook)
  end
end

defmodule BulmaComponents.Storybook.NextController do
  use Phoenix.Controller

  def storybook(conn, _) do
    redirect(conn, to: "/storybook")
  end
end

defmodule BulmaComponents.Storybook.ErrorHTML do
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end

defmodule BulmaComponents.Storybook.Endpoint do
  use Phoenix.Endpoint, otp_app: :bulma_components_storybook

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_bulma_components_storybook_key",
    signing_salt: "3wG6v9qclWU"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :bulma_components_storybook,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]
  plug Plug.Session, @session_options

  plug BulmaComponents.Storybook.Router
end
