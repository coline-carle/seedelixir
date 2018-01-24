defmodule Seedelixir.Discord.Supervisor do
  @moduledoc false
  use Supervisor

  alias Seedelixir.Discord.Consumer
  alias Seedelixir.Discord.PinnedPost.Watcher

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    # List comprehension creates a consumer per cpu core
    children = [
      {Consumer, []},
      {Watcher, []}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
