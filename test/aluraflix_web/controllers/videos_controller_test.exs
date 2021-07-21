defmodule AluraflixWeb.VideosControllerTest do
  use AluraflixWeb.ConnCase, async: true

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
      |> Aluraflix.Video.changeset()
      |> Aluraflix.Repo.insert()

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
end
