defmodule PlugWechat.Ensure do
  @moduledoc """
  Ensure message coming from wechat
  """
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :token)
  end

  def call(conn, token) do
    %{
      "nonce" => nonce,
      "signature" => signature,
      "timestamp" => timestamp,
      "echostr" => echostr
    } = conn.params

    str =
      [nonce, token, timestamp]
      |> Enum.sort()
      |> Enum.join("")

    case :crypto.hash(:sha, str) |> Base.encode16() |> String.downcase() do
      ^signature ->
        conn
        |> put_resp_content_type("text/plain")
        |> send_resp(200, echostr)
        |> halt()

      _ ->
        conn |> halt()
    end
  end
end
