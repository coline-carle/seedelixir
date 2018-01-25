defmodule Seedelixir.Discord.PinnedPost.Watcher do
  @moduledoc false
  use GenServer

  alias Nostrum.Api
  alias Seedelixir.Config
  alias Seedelixir.Decoder
  require Logger
  @required_keys [:title, :date, :time]

  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

  def valid_seedraid?(seedraid) do
    @required_keys
    |> Enum.all?(fn key -> seedraid |> Map.has_key?(key) end)
  end

  def parse_message(message) do
    case message.content |> Decoder.decode() do
      {:ok, data} ->
        case data |> valid_seedraid?() do
          true ->
            bindata =
              data
              |> Poison.Encoder.encode(pretty: true)

            raid = data |> Seedelixir.SeedRaid.transform()
            Logger.info("#{inspect(raid)}")

            File.write("./pins/#{message.id}.json", bindata)

          _ ->
            :noop
        end

      _ ->
        :noop
    end

    File.write("./pins/#{message.id}.content", message.content)
  end

  def init(_) do
    channel_id = Config.channel_id()
    Logger.info("channel_od: #{channel_id}")
    pinned = Api.get_pinned_messages!(channel_id)

    pinned
    |> Enum.each(&parse_message/1)

    {:ok, %{channel_id: channel_id}}
  end
end
