defmodule AluraflixWeb.VideosView do
  use AluraflixWeb, :view

  def render("index.json", %{videos: videos}) do
    %{data: render_many(videos, AluraflixWeb.VideosView, "video.json", as: :video)}
  end

  def render("video.json", %{video: video}) do
    %{id: video.id, title: video.title, description: video.description, url: video.url}
  end
end
