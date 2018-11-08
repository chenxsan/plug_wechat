defmodule PlugWechat.MixProject do
  use Mix.Project

  def project do
    [
      app: :plug_wechat,
      version: "0.2.0",
      description: "Plug for wechat with a xml parser",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/chenxsan/plug_wechat"
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
      {:plug_cowboy, "~> 2.0"},
      {:sweet_xml, "~> 0.6.5"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      links: %{
        "GitHub" => "https://github.com/chenxsan/plug_wechat"
      },
      licenses: ["MIT"]
    ]
  end
end
