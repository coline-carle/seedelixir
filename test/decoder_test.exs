defmodule SeedelixirDecoderTest do
  @moduledoc false

  use ExUnit.Case, async: true
  doctest Seedelixir.Decoder
  alias Seedelixir.Decoder

  test "parse title" do
    informations = %{:title => "title"}
    assert Decoder.decode("<title>") == {:ok, informations}
    assert Decoder.decode("[title]") == {:ok, informations}
    assert Decoder.decode("  [title]") == {:ok, informations}
  end

  test "parse keyvalues" do
    informations = %{:title => "title", "key" => "value"}
    assert Decoder.decode("<title>\n[key](value)") == {:ok, informations}
    assert Decoder.decode("```md\n<title>\n--\n* [key](value)") == {:ok, informations}
  end

  test "normalize keys" do
    informations = %{:title => "title", :seeds => %{seeds_quantity: 600}}
    assert Decoder.decode("<title>\n[SEEDS:](600)") == {:ok, informations}
  end

  test "thalipedes template" do
    {:ok, text} = File.read("./test/fixtures/thalipedes.md")

    informations = %{
      :title => "CREATIVE TITLE HERE",
      :date => %{day: 1, month: 1, weekday: :monday},
      :time => %{hours: 22, minutes: 0},
      :required => %{aethril: 3, felwort: 3},
      :max => %{aethril: 15},
      :seeds => %{seeds_quantity: 60},
      :participants => %{count: 6, max: 10}
    }

    assert Decoder.decode(text) == {:ok, informations}
  end

  test "sholenar template" do
    {:ok, text} = File.read("./test/fixtures/sholenar.md")

    informations = %{
      :title => "100 Mixed",
      :title_tokens => [:mix],
      :date => %{day: 22, month: 1, weekday: :monday, year: 18},
      :time => %{hours: 21, minutes: 0},
      :required => %{aethril: 3, felwort: 3},
      :max => %{foxflower: 0, felwort: 0, any: 50},
      :seeds => %{seeds_quantity: 100},
      :participants => %{count: 10, max: 10}
    }

    assert Decoder.decode(text) == {:ok, informations}
  end
end
