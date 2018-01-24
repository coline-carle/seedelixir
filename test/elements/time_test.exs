defmodule SeedelixirElementTimeTest do
  @moduledoc false

  use ExUnit.Case, async: true
  # doctest Seedelixir.Element.Seeds
  alias Seedelixir.Element.Time

  test "parse time" do
    time = %{:hour => 22, :minute => 00}
    assert Time.decode("22:00 Server Time") == {:ok, time}
  end
end
