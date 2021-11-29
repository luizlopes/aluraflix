defmodule Aluraflix.Tokens.VerifyJWT do
  def call(jwt) do
    JOSE.JWT.verify(jwk(), jwt)
  end

  defp jwk() do
    %{"kty" => "oct", "k" => "secret"}
  end
end
