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
      aliases: [
        dev: "run --no-halt dev.exs"
      ],
      preferred_cli_env: [
        dev: :dev,
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
      # Component deps
      {:mime, "~> 1.6 or ~> 2.0"},
      {:phoenix_live_view, "~> 0.18.3"},
      {:bulma, "~> 0.9.3"},

      # Dev/test dependencies
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phx_live_storybook, "~> 0.4.0", only: :dev},
      {:plug_cowboy, "~> 2.0", only: :dev},
      {:jason, "~> 1.0", only: [:dev, :test]},
      {:dart_sass, "~> 0.5", only: [:dev, :test, :docs]},
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
