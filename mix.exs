defmodule Relix.MixProject do
  use Mix.Project

  def project do
    [
      app: :relix,
      version: "0.1.2",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Remote Execution Library for Elixir",
      package: package(),
      source_url: "https://github.com/valiot/relix"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Relix.Application, []}
    ]
  end

  defp package do
    [
      maintainers: ["Valiot"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/valiot/relix"},
      files: ~w(lib/relix lib/relix.ex priv .formatter.exs mix.exs README.md LICENSE CHANGELOG.md)
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
