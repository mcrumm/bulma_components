defmodule BulmaComponents.MixProject do
  use Mix.Project

  def project do
    [
      app: :bulma_components,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  defp aliases do
    [
      dev: "run --no-halt dev.exs"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Component deps
      {:mime, "~> 1.6 or ~> 2.0"},
      {:phoenix_live_view, "~> 0.18.3"},

      # Dev/test dependencies
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phx_live_storybook, "~> 0.4.0", only: :dev},
      {:plug_cowboy, "~> 2.0", only: :dev},
      {:jason, "~> 1.0", only: [:dev, :test]}
    ]
  end
end
