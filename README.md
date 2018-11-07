# PlugWechat

很不幸，微信公众号的消息是 [xml](https://mp.weixin.qq.com/wiki?t=resource/res_main&id=mp1421140453) 格式，对我、PhoenixFramework 来说，json 都要更方便。

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
然后在你的控制器文件中调用 `PlugWechat.Ensure`：

```elixir
plug PlugWechat.Ensure, [token: "wechat token here"] when action in [:setup]
def setup(_, ) do
end
```

## 文档

[https://hexdocs.pm/plug_wechat](https://hexdocs.pm/plug_wechat)。

