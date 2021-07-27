defmodule AluraflixWeb.CategoriesController do
  use AluraflixWeb, :controller

  alias Aluraflix.{Repo, Category}

  def index(conn, _params) do
    with categories <- Repo.all(Category) do
      conn
      |> put_status(200)
      |> render("index.json", categories: categories)
    end
  end
end
