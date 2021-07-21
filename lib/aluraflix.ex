defmodule Aluraflix do
  @moduledoc """
  Aluraflix keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate all_videos(), to: Aluraflix.Videos.All, as: :call
  defdelegate get_video(params), to: Aluraflix.Videos.Get, as: :call
end
