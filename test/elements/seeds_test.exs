defmodule SeedelixirElementSeedsTest do
  @moduledoc false

  use ExUnit.Case, async: true
  # doctest Seedelixir.Element.Seeds
  alias Seedelixir.Element.Seeds

  test "parse participants" do
    seeds = %{quantity: 50}
    assert Seeds.decode("50") == {:ok, seeds}
  end
end
