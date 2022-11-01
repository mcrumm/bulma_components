defmodule BulmaComponents.MixProject do
  use Mix.Project

  def project do
    [
      app: :bulma_components,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:phoenix_live_view, "~> 0.18.0"},

      # Dev/test dependencies
      {:phx_live_storybook, "~> 0.4.0", only: :dev},
      {:jason, "~> 1.0", optional: true}
    ]
  end
end
