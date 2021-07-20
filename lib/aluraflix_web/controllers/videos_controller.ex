defmodule AluraflixWeb.VideosController do
  use AluraflixWeb, :controller

  def index(conn, _params) do
    with videos <- Aluraflix.all_videos() do
      conn
      |> put_status(200)
      |> render("index.json", videos: videos)
    end
  end
end
