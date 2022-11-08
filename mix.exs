defmodule BulmaComponents.MixProject do
  use Mix.Project

  @version "0.0.1-alpha.1"

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
      {:mime, "~> 1.6 or ~> 2.0"},
      {:phoenix_live_view, "~> 0.18.3"},
      {:bulma, "~> 0.9.3"},
      # Dev/test dependencies
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:ex_doc, "~> 0.29", only: :docs}
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
end
