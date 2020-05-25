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
      |> Enum.map(fn x -> String.split(x, [",", "\n", " "]) |> Enum.take(3) end)
      |> Enum.map(fn [first, second, third] ->
        <<?:, tail::binary>> = second
        IO.puts(tail)
        [String.to_integer(first), String.to_atom(tail), String.to_float(third)]
      end)

    Enum.map(values, fn x -> Enum.zip(keys, x) |> Keyword.new() end) |> sales_tax
  end

  @tax_rates [NC: 0.075, TX: 0.08]
  def sales_tax(orders, tax_rates \\ @tax_rates) when is_list(orders) and is_list(tax_rates) do
    for [id: _id, ship_to: ship_to, net_amount: net_amount] = order <- orders do
      case Keyword.has_key?(tax_rates, ship_to) do
        true ->
          order ++ [total_amount: net_amount * (1 + Keyword.get(tax_rates, ship_to))]

        _ ->
          order ++ [total_amount: net_amount]
      end
    end
  end
end
