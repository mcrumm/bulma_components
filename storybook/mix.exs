defmodule BulmaComponents.Storybook.MixProject do
  use Mix.Project

  @version "0.0.1-alpha.1"

  @source_url "https://github.com/mcrumm/bulma_components"

  def project do
    [
      app: :bulma_components_storybook,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: [
        maintainers: ["Michael A. Crumm Jr."],
        description: "BulmaComponents Storybook",
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url}
      ],
      docs: docs(),
      aliases: [
        "assets.deploy": [
          "sass default --embed-source-map --style=compressed",
          "phx.digest"
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {BulmaComponents.Storybook.Application, []}
    ]
  end

  defp deps do
    [
      {:bulma_components, path: Path.expand("../", __DIR__)},
      {:phx_live_storybook, "~> 0.4.0"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.0"},
      {:dart_sass, "~> 0.5", runtime: Mix.env() == :dev},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.29", only: :docs}
    ]
  end

  defp docs do
    [
      source_url_pattern: "#{@source_url}/blob/v#{@version}/storybook/%{path}#L%{line}"
    ]
  end
end
