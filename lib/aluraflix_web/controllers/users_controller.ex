defmodule AluraflixWeb.UsersController do
  use AluraflixWeb, :controller

  alias Aluraflix.User
  alias Aluraflix.Users.CheckCredentials
  alias Aluraflix.Tokens.GenerateJWT

  def login(conn, params) do
    jwt_token =
      CheckCredentials.call(params)
      |> handle_response

    conn
    |> put_status(200)
    |> json(%{"token" => jwt_token})
  end

  defp handle_response({:ok, %User{} = user}) do
    {%{}, token} = GenerateJWT.call(user)
    token
  end
end
