defmodule Seedelixir.Discord.Consumer do
  @moduledoc false

  use Nostrum.Consumer
  # alias Nostrum.Api
  require Logger

  def child_spec(args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [args]},
      type: :worker
    }
  end

  def start_link(_) do
    Consumer.start_link(__MODULE__, :state)
  end

  def handle_event({:CHANNEL_PINS_UPDATE, {_map}, _ws_state}, state) do
    {:ok, state}
  end

  def handle_event({:MESSAGE_UPDATE, {_msg}, _ws_state}, state) do
    {:ok, state}
  end

  def handle_event(_, state) do
    {:ok, state}
  end
end
