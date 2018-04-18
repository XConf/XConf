defmodule XConf.Mixfile do
  use Mix.Project

  def project do
    [
      app: :x_conf,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {XConf.Application, []},
      extra_applications: [:logger, :runtime_tools, :yaml_elixir]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},

      # Database
      {:postgrex, ">= 0.0.0"},

      # Codec
      {:poison, "~> 3.1"},

      # GraphQL
      {:absinthe, "~> 1.4.0"},
      {:absinthe_relay, "~> 1.4"},
      {:absinthe_ecto, "~> 0.1.3"},
      {:absinthe_plug, "~> 1.4.0"},

      # Presentation Layer
      {:gettext, "~> 0.11"},

      # Frontend
      {:phoenix_html, "~> 2.10"},
      {:cowboy, "~> 1.0"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},

      {:ecto_enum, "~> 1.0"},
      {:yaml_elixir, "~> 2.0.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
