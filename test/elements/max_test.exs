defmodule SeedelixirElementMaxTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest Seedelixir.Element.Max
  alias Seedelixir.Element.Max

  test "parse participants" do
    max = %{:aethril => 15}
    assert Max.decode("15 AT") == {:ok, max}
  end
end
