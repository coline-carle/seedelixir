defmodule Seedelixir.Config do
  def channel_id do
    Application.get_env(:seedelixir, :channel_id)
  end
end
