defmodule Seedelixir.Element.Time do
  @moduledoc false

  @digits '01234556789'
  @hours 0
  @minutes 1

  alias Seedelixir.DecodeError

  def decode(data) do
    try do
      hours(data, data, 0, [])
    catch
      {:position, position} ->
        {:error, %DecodeError{position: position, data: data}}
    else
      value ->
        {:ok, value |> Enum.into(%{})}
    end
  end

  defp minutes(<<byte, rest::bits>>, original, skip, stack, len) when byte in @digits do
    minutes(rest, original, skip, stack, len + 1)
  end

  defp minutes(<<byte, _::bits>>, original, skip, stack, len) when byte in '\s\t' do
    minutes(<<>>, original, skip, stack, len)
  end

  defp minutes(<<>>, original, skip, stack, len) do
    value =
      original
      |> binary_part(skip, len)
      |> String.to_integer()

    continue(<<>>, original, skip, stack, value)
  end

  defp minutes(<<_::bits>>, original, skip, _stack, len) do
    error(original, skip + len)
  end

  defp hours(<<byte, rest::bits>>, original, skip, stack) when byte in @digits do
    hours(rest, original, skip, [@hours | stack], 1)
  end

  defp hours(<<_, rest::bits>>, original, skip, stack) do
    hours(rest, original, skip + 1, stack)
  end

  defp hours(<<>>, original, skip, _stack) do
    error(original, skip)
  end

  defp hours(<<byte, rest::bits>>, original, skip, stack, len) when byte in @digits do
    hours(rest, original, skip, stack, len + 1)
  end

  defp hours(<<?:, rest::bits>>, original, skip, stack, len) do
    value =
      original
      |> binary_part(skip, len)
      |> String.to_integer()

    continue(rest, original, skip + 1 + len, stack, value)
  end

  defp hours(<<_::bits>>, original, skip, _stack, len) do
    error(original, skip + len)
  end

  defp hours_value(rest, original, skip, stack, value) do
    stack = [@minutes, {:hours, value} | stack]
    minutes(rest, original, skip, stack, 0)
  end

  defp minutes_value(_rest, _original, _skip, stack, value) do
    [{:minutes, value} | stack]
  end

  defp continue(rest, original, skip, stack, value) do
    case stack do
      [@hours | stack] ->
        hours_value(rest, original, skip, stack, value)

      [@minutes | stack] ->
        minutes_value(rest, original, skip, stack, value)
    end
  end

  defp error(_original, skip) do
    throw({:position, skip})
  end
end
