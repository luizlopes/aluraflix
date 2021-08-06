defmodule AluraflixWeb.VideosControllerTest do
  use AluraflixWeb.ConnCase, async: true

  alias Aluraflix.{Repo, Video, Category}

  describe "index/2" do
    test "when there aren't videos records, then return empty list", %{conn: conn} do
      response =
        conn
        |> get(Routes.videos_path(conn, :index, %{}))
        |> json_response(200)

      assert %{
               "data" => []
             } = response
    end

    test "when there are videos records, then return all", %{conn: conn} do
      params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      params
      |> Video.changeset()
      |> Repo.insert()

      response =
        conn
        |> get(Routes.videos_path(conn, :index, %{}))
        |> json_response(200)

      assert %{
               "data" => [
                 %{
                   "id" => _id,
                   "description" => "video 1...",
                   "title" => "video #01",
                   "url" => "http://yt/video/1"
                 }
               ]
             } = response
    end

    test "when there are videos records and a search param is passed through, then return all matched videos",
         %{conn: conn} do
      params_01 = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      params_02 = %{
        title: "phoenix framework",
        description: "phoenix is great",
        url: "http://yt/video/3"
      }

      params_01
      |> Video.changeset()
      |> Repo.insert()

      params_02
      |> Video.changeset()
      |> Repo.insert()

      search_param = %{"search" => "phoenix"}

      response =
        conn
        |> get(Routes.videos_path(conn, :index, search_param))
        |> json_response(200)

      assert %{
               "data" => [
                 %{
                   "id" => _id,
                   "description" => "phoenix is great",
                   "title" => "phoenix framework",
                   "url" => "http://yt/video/3"
                 }
               ]
             } = response
    end
  end

  describe "show/2" do
    test "when id is valid, then return the video", %{conn: conn} do
      params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      {:ok, %Video{id: id}} =
        params
        |> Video.changeset()
        |> Repo.insert()

      response =
        conn
        |> get(Routes.videos_path(conn, :show, id))
        |> json_response(200)

      assert %{
               "data" => %{
                 "id" => ^id,
                 "title" => "video #01",
                 "description" => "video 1...",
                 "url" => "http://yt/video/1"
               }
             } = response
    end

    test "when id doesn't exist, then return status 404 (not found)", %{conn: conn} do
      id = 321

      response =
        conn
        |> get(Routes.videos_path(conn, :show, id))
        |> json_response(404)

      assert %{
               "message" => "resource not found"
             } = response
    end
  end

  describe "create/2" do
    test "when all params are valid without categories, then return the created video with one category",
         %{conn: conn} do
      Aluraflix.Categories.Create.call(%{title: "Free", color: "Green"})

      params = %{
        "categories" => nil,
        "title" => "video #01",
        "description" => "video 1...",
        "url" => "http://yt/video/1"
      }

      response =
        conn
        |> post(Routes.videos_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "data" => %{
                 "id" => _id,
                 "title" => "video #01",
                 "description" => "video 1...",
                 "url" => "http://yt/video/1",
                 "categories" => [
                   %{
                     "title" => "Free",
                     "color" => "Green"
                   }
                 ]
               }
             } = response
    end

    test "when all params are valid with two categories, then return the created video with the categories",
         %{conn: conn} do
      {:ok, %Category{id: free_category_id}} =
        Aluraflix.Categories.Create.call(%{title: "Free", color: "Green"})

      {:ok, %Category{id: comedy_category_id}} =
        Aluraflix.Categories.Create.call(%{title: "Comedy", color: "Orange"})

      params = %{
        "categories" => [%{"id" => free_category_id}, %{"id" => comedy_category_id}],
        "title" => "video #01",
        "description" => "video 1...",
        "url" => "http://yt/video/1"
      }

      response =
        conn
        |> post(Routes.videos_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "data" => %{
                 "id" => _id,
                 "title" => "video #01",
                 "description" => "video 1...",
                 "url" => "http://yt/video/1",
                 "categories" => [
                   %{
                     "id" => ^free_category_id,
                     "title" => "Free",
                     "color" => "Green"
                   },
                   %{
                     "id" => ^comedy_category_id,
                     "title" => "Comedy",
                     "color" => "Orange"
                   }
                 ]
               }
             } = response
    end

    test "when params is empty, then return an error", %{conn: conn} do
      params = %{}

      response =
        conn
        |> post(Routes.videos_path(conn, :create, params))
        |> json_response(400)

      assert %{
               "description" => ["can't be blank"],
               "title" => ["can't be blank"],
               "url" => ["can't be blank"]
             } = response
    end

    test "when params are invalid, then return an error", %{conn: conn} do
      params = %{title: ".", description: ".", url: "."}

      response =
        conn
        |> post(Routes.videos_path(conn, :create, params))
        |> json_response(400)

      assert %{
               "description" => ["should be at least 3 character(s)"],
               "title" => ["should be at least 3 character(s)"]
             } = response
    end
  end

  describe "update/2" do
    test "when all params are valid, then return the updated video", %{conn: conn} do
      Aluraflix.Categories.Create.call(%{title: "Free", color: "Green"})

      create_params = %{
        "title" => "video #01",
        "description" => "video 1...",
        "url" => "http://yt/video/1",
        "categories" => nil
      }

      {:ok, %Video{id: id}} = Aluraflix.Videos.Create.call(create_params)

      update_params = %{
        title: "updated video",
        description: "updated video 1...",
        url: "http://yt/updatedvideo/1"
      }

      response =
        conn
        |> patch(Routes.videos_path(conn, :update, id, update_params))
        |> json_response(200)

      assert %{
               "data" => %{
                 "id" => ^id,
                 "title" => "updated video",
                 "description" => "updated video 1...",
                 "url" => "http://yt/updatedvideo/1"
               }
             } = response
    end

    test "when there are invalid params, then return an error", %{conn: conn} do
      Aluraflix.Categories.Create.call(%{title: "Free", color: "Green"})

      create_params = %{
        "title" => "video #01",
        "description" => "video 1...",
        "url" => "http://yt/video/1",
        "categories" => nil
      }

      {:ok, %Video{id: id}} = Aluraflix.Videos.Create.call(create_params)

      update_params = %{title: "x", description: "x", url: "x"}

      response =
        conn
        |> patch(Routes.videos_path(conn, :update, id, update_params))
        |> json_response(400)

      assert %{
               "description" => ["should be at least 3 character(s)"],
               "title" => ["should be at least 3 character(s)"]
             } = response
    end

    test "when the video id doens't exists, then return an not found video error", %{conn: conn} do
      invalid_id = 98765

      update_params = %{
        title: "updated video",
        description: "updated video 1...",
        url: "http://yt/updatedvideo/1"
      }

      response =
        conn
        |> patch(Routes.videos_path(conn, :update, invalid_id, update_params))
        |> json_response(404)

      assert %{
               "message" => "resource not found"
             } = response
    end
  end
end
