defmodule AluraflixWeb.CategoriesControllerTest do
  use AluraflixWeb.ConnCase, async: true

  alias Aluraflix.{Repo, Category}
  alias Aluraflix.Categories.Create

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

  describe "update/2" do
    test "when all params are valid, then return the updated category", %{conn: conn} do
      create_params = %{title: "category #01", color: "Yellow"}

      {:ok, %Category{id: id}} = Create.call(create_params)

      update_params = %{
        title: "updated Category",
        color: "Brown"
      }

      response =
        conn
        |> patch(Routes.categories_path(conn, :update, id, update_params))
        |> json_response(200)

      assert %{
               "data" => %{
                 "id" => ^id,
                 "title" => "updated Category",
                 "color" => "Brown"
               }
             } = response
    end

    test "when there are invalid params, then return an error", %{conn: conn} do
      create_params = %{title: "Category #01", color: "Yellow"}

      {:ok, %Category{id: id}} = Create.call(create_params)

      update_params = %{title: "x", color: "x"}

      response =
        conn
        |> patch(Routes.categories_path(conn, :update, id, update_params))
        |> json_response(400)

      assert %{
               "color" => ["should be at least 3 character(s)"],
               "title" => ["should be at least 3 character(s)"]
             } = response
    end

    test "when the category id doens't exists, then return a not found category error", %{
      conn: conn
    } do
      invalid_id = 98765

      update_params = %{
        title: "updated Category",
        color: "Dark grey"
      }

      response =
        conn
        |> patch(Routes.categories_path(conn, :update, invalid_id, update_params))
        |> json_response(404)

      assert %{
               "message" => "resource not found"
             } = response
    end
  end
end
