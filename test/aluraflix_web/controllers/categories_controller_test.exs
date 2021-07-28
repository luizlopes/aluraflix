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

  describe "show/2" do
    test "when id is valid, then return the category", %{conn: conn} do
      params = %{title: "category #01", color: "Red"}

      {:ok, %Category{id: id}} =
        params
        |> Category.changeset()
        |> Repo.insert()

      response =
        conn
        |> get(Routes.categories_path(conn, :show, id))
        |> json_response(200)

      assert %{
               "data" => %{
                 "id" => ^id,
                 "title" => "category #01",
                 "color" => "Red"
               }
             } = response
    end

    test "when id doesn't exist, then return status 404 (not found)", %{conn: conn} do
      id = 321

      response =
        conn
        |> get(Routes.categories_path(conn, :show, id))
        |> json_response(404)

      assert %{
               "message" => "resource not found"
             } = response
    end
  end

  describe "create/2" do
    test "when all params are valid, then return the created category", %{conn: conn} do
      params = %{title: "category #01", color: "black"}

      response =
        conn
        |> post(Routes.categories_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "data" => %{
                 "id" => _id,
                 "title" => "category #01",
                 "color" => "black"
               }
             } = response
    end

    test "when params is empty, then return an error", %{conn: conn} do
      params = %{}

      response =
        conn
        |> post(Routes.categories_path(conn, :create, params))
        |> json_response(400)

      assert %{
               "title" => ["can't be blank"],
               "color" => ["can't be blank"]
             } = response
    end

    test "when params are invalid, then return an error", %{conn: conn} do
      params = %{title: ".", color: "."}

      response =
        conn
        |> post(Routes.categories_path(conn, :create, params))
        |> json_response(400)

      assert %{
               "color" => ["should be at least 3 character(s)"],
               "title" => ["should be at least 3 character(s)"]
             } = response
    end
  end
end
