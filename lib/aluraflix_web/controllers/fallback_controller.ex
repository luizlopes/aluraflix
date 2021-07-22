defmodule AluraflixWeb.FallbackController do
  use AluraflixWeb, :controller

  alias AluraflixWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", message: "resource not found")
  end

  def call(conn, {:error, %Ecto.Changeset{} = result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", %{result: result})
  end
end
