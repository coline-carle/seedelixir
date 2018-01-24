defmodule SeedelixirTest do
  @moduledoc false

  use ExUnit.Case
  doctest Seedelixir

  test "greets the world" do
    assert Seedelixir.hello() == :world
  end
end
