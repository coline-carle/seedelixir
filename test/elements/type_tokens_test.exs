defmodule SeedelixirElementTypeTokenTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest Seedelixir.Element.TypeToken
  alias Seedelixir.Element.TypeToken

  test "pars tokens" do
    tokens = [:starlight_rose]
    assert TypeToken.decode("ONLY SLR") == {:ok, tokens}
  end
end
