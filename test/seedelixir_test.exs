defmodule SeedelixirTest do
  use ExUnit.Case
  doctest Seedelixir

  test "greets the world" do
    assert Seedelixir.hello() == :world
  end
end
