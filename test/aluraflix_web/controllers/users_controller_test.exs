defmodule AluraflixWeb.UsersControllerTest do
  use AluraflixWeb.ConnCase, async: true

  alias Aluraflix.{Repo, User}

  describe "login/2" do
    test "when the e-mail e password are valid, then return a token", %{conn: conn} do
      User.changeset(%{"name" => "Test", "email" => "teste@email.com", "password" => "abc123"})
      |> Repo.insert()

      params = %{"email" => "teste@email.com", "password" => "abc123"}

      response =
        conn
        |> post(Routes.users_path(conn, :login, params))
        |> json_response(200)

      assert %{"token" => _token} = response
    end
  end
end
