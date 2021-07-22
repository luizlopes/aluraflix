defmodule AluraflixWeb.VideosControllerTest do
  use AluraflixWeb.ConnCase, async: true

  alias Aluraflix.{Repo, Video}

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
    test "when all params are valid, then return the created video", %{conn: conn} do
      params = %{title: "video #01", description: "video 1...", url: "http://yt/video/1"}

      response =
        conn
        |> post(Routes.videos_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "data" => %{
                 "id" => _id,
                 "title" => "video #01",
                 "description" => "video 1...",
                 "url" => "http://yt/video/1"
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
end
