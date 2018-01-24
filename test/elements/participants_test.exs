defmodule SeedelixirElementParticipantsTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest Seedelixir.Element.Participants
  alias Seedelixir.Element.Participants

  test "parse participants" do
    participants = %{:participants_max => 10, :participants => 2}
    assert Participants.decode("2/10") == {:ok, participants}
  end
end
