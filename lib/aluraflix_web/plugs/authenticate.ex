defmodule Plugs.Authenticate do
  import Plug.Conn

  alias Aluraflix.Tokens.VerifyJWT

  def init(default), do: default

  def call(conn, _options) do
    conn.req_headers 
    |> authorization_header
    |> handle_authorization(conn)
  end

  defp authorization_header(headers) do
    headers
    |> Enum.filter(fn {key, _value} -> key == "authorization" end)
    |> List.first
  end

  defp handle_authorization({"authorization", token}, conn) do
    {is_valid, _jwt, _jws} = VerifyJWT.call(token)

    case is_valid do
      true -> conn
      false -> conn |> resp(401, "{\"message\": \"A token must be in authorization header\"}") |> halt
    end
  end

  defp handle_authorization(nil, conn) do
    conn
    |> resp(401, "{\"message\": \"A token must be in authorization header\"}")
    |> halt()
  end
end
