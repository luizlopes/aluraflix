defmodule AluraflixWeb.CategoriesController do
  use AluraflixWeb, :controller

  alias Aluraflix.Categories.All

  def index(conn, _params) do
    with categories <- All.call() do
      conn
      |> put_status(200)
      |> render("index.json", categories: categories)
    end
  end
end
