defmodule AluraflixWeb.CategoriesController do
  use AluraflixWeb, :controller

  alias Aluraflix.Categories.{All, Get}

  action_fallback AluraflixWeb.FallbackController

  def index(conn, _params) do
    with categories <- All.call() do
      conn
      |> put_status(200)
      |> render("index.json", categories: categories)
    end
  end

  def show(conn, params) do
    with {:ok, category} <- Get.call(params) do
      conn
      |> put_status(200)
      |> render("show.json", category: category)
    end
  end
end
