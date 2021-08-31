defmodule Aluraflix.Users.CheckCredentials do
  alias Aluraflix.{Repo, User}

  def call(%{"email" => email, "password" => password}) do
    case Repo.get_by(User, email: email, password: password) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
