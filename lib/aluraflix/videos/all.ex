defmodule Aluraflix.Videos.All do
  alias Aluraflix.{Repo, Video}

  def call() do
    Repo.all(Video)
  end
end
