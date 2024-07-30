defmodule ElixirDropbox.Mixfile do
  use Mix.Project

  @description """
    Simple Elixir wrapper for the Dropbox v2 API
  """

  def project do
    [
      app: :elixir_dropbox,
      version: "0.0.8",
      elixir: "~> 1.13",
      name: "ElixirDropbox",
      elixirc_paths: elixirc_paths(Mix.env()),
      description: @description,
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :req]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Type "mix help deps" for more examples and options
  defp deps do
    [
      #  {:httpoison, "~> 1.0"},
      # {:poison, "~> 1.5"},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      #   {:json, "~> 0.3.0"},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: :test},
      {:excoveralls, "~> 0.7", only: :test},
      {:credo, "~> 0.9.0-rc1", only: [:dev, :test], runtime: false},
      {:req, "~> 0.5.0"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"]
    ]
  end

  defp package do
    [
      maintainers: ["Spiros Gerokostas"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/sger/elixir_dropbox"}
    ]
  end
end
