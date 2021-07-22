defmodule AluraflixWeb.VideosController do
  use AluraflixWeb, :controller

  alias Aluraflix.Video

  action_fallback AluraflixWeb.FallbackController

  def index(conn, _params) do
    with videos <- Aluraflix.all_videos() do
      conn
      |> put_status(200)
      |> render("index.json", videos: videos)
    end
  end

  def show(conn, params) do
    with {:ok, %Video{} = video} <- Aluraflix.get_video(params) do
      conn
      |> put_status(200)
      |> render("show.json", video: video)
    end
  end

  def create(conn, params) do
    with {:ok, %Video{} = video} <- Aluraflix.create_video(params) do
      conn
      |> put_status(201)
      |> render("show.json", video: video)
    end
  end
end
