defmodule Order do
  def list(orders, tax_rates) when is_list(orders) and is_list(tax_rates) do
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
