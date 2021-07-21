defmodule AluraflixWeb.FallbackController do
  use AluraflixWeb, :controller

  alias AluraflixWeb.ErrorView

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", message: "resource not found")
  end
end
