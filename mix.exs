defmodule FileManager.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_manager,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison],
      extra_applications: [:logger, :public_key, :poison, :json, :pandex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # lib para requests seguros
      {:ssl_verify_fun, "~> 1.1.7", manager: :rebar3, override: true},
      {:poison, "~> 4.0"},
      {:httpoison, "~> 2.2.1"},
      {:json, "~> 1.4"},
      {:pandex, "~> 0.2.0"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
