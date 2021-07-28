defmodule AluraflixWeb.CategoriesController do
  use AluraflixWeb, :controller

  alias Aluraflix.Category
  alias Aluraflix.Categories.{All, Get, Create, Update}

  action_fallback AluraflixWeb.FallbackController

  def index(conn, _params) do
    with categories <- All.call() do
      conn
      |> put_status(200)
      |> render("index.json", categories: categories)
    end
  end

  def show(conn, params) do
    with {:ok, %Category{} = category} <- Get.call(params) do
      conn
      |> put_status(200)
      |> render("show.json", category: category)
    end
  end

  def create(conn, params) do
    with {:ok, %Category{} = category} <- Create.call(params) do
      conn
      |> put_status(201)
      |> render("show.json", category: category)
    end
  end

  def update(conn, params) do
    with {:ok, %Category{} = category} <- Get.call(params),
         {:ok, %Category{} = updated_category} <- Update.call(category, params) do
      conn
      |> put_status(200)
      |> render("show.json", category: updated_category)
    end
  end
end
