defmodule AluraflixWeb.CategoriesControllerTest do
  use AluraflixWeb.ConnCase, async: true

  alias Aluraflix.{Repo, Category}

  describe "index/2" do
    test "when there aren't categories registereds, then return an empty list", %{conn: conn} do
      response =
        conn
        |> get(Routes.categories_path(conn, :index, %{}))
        |> json_response(200)

      assert %{
               "data" => []
             } = response
    end

    test "when there are categories registereds, then return all", %{conn: conn} do
      params = %{title: "Drama", color: "Blue"}

      params
      |> Category.changeset()
      |> Repo.insert()

      response =
        conn
        |> get(Routes.categories_path(conn, :index, %{}))
        |> json_response(200)

      assert %{
               "data" => [
                 %{
                   "id" => _id,
                   "title" => "Drama",
                   "color" => "Blue"
                 }
               ]
             } = response
    end
  end
end
