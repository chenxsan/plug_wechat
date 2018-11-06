defmodule PlugWechat.EnsureTest do
  use ExUnit.Case
  use Plug.Test

  test "conn is halted" do
    conn =
      conn(:get, "/api/wechat", %{nonce: "", signature: "", timestamp: "", echostr: ""})
      |> PlugWechat.Ensure.call("this is wechat token")

    assert conn.halted == true
  end

  test "token should be pass" do
    assert_raise KeyError, fn ->
      PlugWechat.Ensure.init([])
    end
  end
end
