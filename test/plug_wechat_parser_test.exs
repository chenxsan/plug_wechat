defmodule PlugWechat.Parsers.WECHATTest do
  use ExUnit.Case, async: true
  use Plug.Test

  def xml_conn(body, content_type \\ "text/xml") do
    put_req_header(conn(:post, "/", body), "content-type", content_type)
  end

  def parse(conn, opts \\ []) do
    opts =
      opts
      |> Keyword.put_new(:parsers, [PlugWechat.Parsers.WECHAT])

    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end

  test "parses the request body" do
    conn = ~s(<xml><ToUserName><![CDATA[Sam]]></ToUserName>
    <FromUserName><![CDATA[Chen]]></FromUserName>
    <CreateTime>1541600409</CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[12]]></Content>
    <MsgId>6621123340578104392</MsgId>
    </xml>) |> xml_conn() |> parse()
    assert conn.params |> Map.get("ToUserName") == "Sam"
    assert conn.params |> Map.get("FromUserName") == "Chen"
    assert conn.params |> Map.get("CreateTime") == 1_541_600_409
    assert conn.params |> Map.get("MsgType") == "text"
    assert conn.params |> Map.get("Content") == "12"
    assert conn.params |> Map.get("MsgId") == 6_621_123_340_578_104_392
    assert conn.params |> Map.get("Location_X") == nil
    assert conn.params |> Map.get("Event") == nil
  end
end
