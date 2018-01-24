defmodule Seedelixir.Element.Style do
  @moduledoc false

  alias Seedelixir.Normalizer

  @values %{
    "2-Phase" => :two_phase
  }

  def decode(data) do
    {:ok,
     data
     |> Normalizer.normalize(@values)}
  end
end
