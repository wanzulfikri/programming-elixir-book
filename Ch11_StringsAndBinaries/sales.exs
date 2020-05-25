defmodule Sales do
  def readSalesCSV(filename) when is_binary(filename) do
    {:ok, file} = File.open(filename, [:utf8, :read])

    keys =
      IO.read(file, :line)
      |> String.split([",", " \n"])
      |> Enum.take(3)
      |> Enum.map(&String.to_atom(&1))

    values =
      IO.stream(file, :line)
      |> Enum.map(fn x -> String.split(x, [",", "\n"]) |> Enum.take(3) end)

    Enum.map(values, fn x -> Enum.zip(keys, x) |> Keyword.new() end)
  end
end
