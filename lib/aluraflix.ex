defmodule Aluraflix do
  @moduledoc """
  Aluraflix keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Aluraflix.Videos

  defdelegate all_videos(params), to: Videos.All, as: :call
  defdelegate get_video(params), to: Videos.Get, as: :call
  defdelegate create_video(params), to: Videos.Create, as: :call
  defdelegate update_video(video, params), to: Videos.Update, as: :call
end
