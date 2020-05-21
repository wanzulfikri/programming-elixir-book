defmodule DQS do
  def center(list) when is_list(list) do
    longest(list)
    |> center_all(list)
  end

  defp longest(list) when is_list(list) do
    Enum.reduce(list, fn x, acc ->
      case String.length(x) > String.length(acc) do
        true -> x
        false -> acc
      end
    end)
    |> String.length()
  end

  defp center_all(col_length, list) when is_integer(col_length) and is_list(list) do
    Enum.map(list, fn
      x ->
        mid_length = (col_length - String.length(x)) / 2
        word_length = String.length(x)
        left = trunc(Float.floor(mid_length) + word_length)

        String.pad_leading(x, left)
        |> String.pad_trailing(col_length)
        |> IO.puts()
    end)
  end
end
