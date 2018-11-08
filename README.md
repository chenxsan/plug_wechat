# PlugWechat

很不幸，微信公众号的消息体是 [text/xml](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140453) 格式，PhoenixFramework [默认并不解析 xml](https://hexdocs.pm/plug/Plug.Parsers.html#module-built-in-parsers)，也因此我们需要引入一个 xml 解析器。

另外，我们还需要验证消息[来自于微信](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421135319)。

这两件事，都可以借助 Plug 完成，这便是 `PlugWechat` 的作用。

## 安装

在 `mix.exs` 文件中添加 `plug_wechat` 依赖：

```elixir
def deps do
  [
    {:plug_wechat, "~> 0.1.0"}
  ]
end
```

在控制器文件中调用 `PlugWechat.Ensure` 确保消息来源：

```elixir
plug PlugWechat.Ensure, [token: "wechat token here"] when action in [:setup]
def setup(_, ) do
end
```

此外，还需要在 `endpoint.ex` 文件中增加解析器如下：

```elixir
plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, PlugWechat.Parsers.WECHAT],
```

这样，微信的 xml 消息体就会被解析为 map。
