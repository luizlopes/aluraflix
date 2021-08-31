defmodule Aluraflix.Tokens.GenerateJWT do
  def call(payload) do
    JOSE.JWT.sign(jwk(), header(), body(payload)) |> JOSE.JWS.compact()
  end

  defp jwk() do
    %{"kty" => "oct", "k" => "secret"}
  end

  defp header() do
    %{"alg" => "HS256"}
  end

  defp body(payload) do
    payload
    |> Map.put("date", DateTime.utc_now())
    |> Map.put("exp", expires_in())
  end

  defp expires_in() do
    DateTime.utc_now()
    |> DateTime.add(jwt_expiration_time_minutes() * 60, :second)
    |> DateTime.to_unix()
  end

  defp jwt_expiration_time_minutes() do
    60
  end
end
