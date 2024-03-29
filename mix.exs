defmodule SwaggerSeparator.MixProject do
  use Mix.Project

  def project do
    [
      app: :swagger_separator,
      version: "0.1.1",
      elixir: "~> 1.7",
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
      {:phoenix_swagger, ">= 0.8.0"}
    ]
  end
end
