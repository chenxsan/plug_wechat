defmodule PlugWechat.Parsers.WECHAT do
  @moduledoc """
  Parses xml request body for wechat message
  """

  @behaviour Plug.Parsers
  alias Plug.Conn
  import SweetXml

  def init(opts) do
    opts
  end

  def parse(conn, "text", "xml", _params, opts) do
    case Conn.read_body(conn, opts) do
      {:ok, body, conn} ->
        {:ok,
         body
         |> xmap(
           ToUserName: ~x"//ToUserName/text()"s,
           FromUserName: ~x"//FromUserName/text()"s,
           CreateTime: ~x"//CreateTime/text()"i,
           MsgType: ~x"//MsgType/text()"s,
           Content: ~x"//Content/text()"s,
           MsgId: ~x"//MsgId/text()"i,
           PicUrl: ~x"//PicUrl/text()"s,
           MediaId: ~x"//MediaId/text()"s,
           Format: ~x"//Format/text()"s,
           Recognition: ~x"//Recognition/text()"s,
           ThumbMediaId: ~x"//ThumbMediaId/text()"s,
           Location_X: ~x"//Location_X/text()"Fo,
           Location_Y: ~x"//Location_Y/text()"Fo,
           Scale: ~x"//Scale/text()"Fo,
           Label: ~x"//Label/text()"s,
           Title: ~x"//Title/text()"s,
           Description: ~x"//Description/text()"s,
           Url: ~x"//Url/text()"s,
           Event: ~x"//Event/text()"s,
           EventKey: ~x"//EventKey/text()"s,
           Ticket: ~x"//Ticket/text()"s,
           Latitude: ~x"//Latitude/text()"Fo,
           Longitude: ~x"//Longitude/text()"Fo,
           Precision: ~x"//Precision/text()"Fo
         )
         |> Enum.reject(fn {_, v} ->
           is_nil(v) or (is_binary(v) and String.trim(v) == "")
         end)
         |> Map.new(), conn}

      {:more, _data, conn} ->
        {:error, :too_large, conn}

      {:error, :timeout} ->
        raise Plug.TimeoutError

      {:error, _} ->
        raise Plug.BadRequestError
    end
  end

  def parse(conn, _type, _subtype, _params, _opts) do
    {:next, conn}
  end
end
