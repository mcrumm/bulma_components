defmodule BulmaComponents.MixProject do
  use Mix.Project

  @version "0.1.0"

  @source_url "https://github.com/mcrumm/bulma_components"

  def project do
    [
      app: :bulma_components,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      docs: docs(),
      aliases: aliases(),
      preferred_cli_env: [
        docs: :docs,
        "hex.publish": :docs
      ]
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
      # Component dependencies
      {:bulma, "~> 0.9.4"},
      {:gettext, "~> 0.24"},
      {:mime, "~> 2.0"},
      {:phoenix_live_view, "~> 0.20"},
      # Dev/test dependencies
      {:credo, "~> 1.7", only: [:dev, :test]},
      {:jason, "~> 1.4", only: [:dev, :test]},
      {:ex_doc, "~> 0.31", only: :docs}
    ]
  end

  defp package do
    [
      maintainers: ["Michael A. Crumm Jr."],
      description: "HEEx components for the Bulma CSS framework.",
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Sponsor" => "https://github.com/sponsors/mcrumm"
      }
    ]
  end

  defp docs do
    [
      source_url: @source_url,
      source_ref: "v#{@version}",
      language: "en",
      formatters: ["html"],
      main: BulmaComponents.Elements,
      extras: [
        "README.md",
        "CHANGELOG.md"
      ]
    ]
  end

  defp aliases do
    [
      setup: ["cmd --cd storybook mix setup"],
      "phx.server": ["cmd --cd storybook mix phx.server"]
    ]
  end
end
