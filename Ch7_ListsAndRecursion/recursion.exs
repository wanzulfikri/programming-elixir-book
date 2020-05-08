defmodule Recursion do
  def mapsum([], _func), do: 0
  def mapsum([head | tail], func), do: func.(head) + mapsum(tail, func)

  def max([max | []]), do: max
  def max([max | [next | tail]]) when max >= next, do: max([max | tail])
  def max([max | [next | tail]]) when max < next, do: max([next | tail])

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n <= 122, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n) when head + n > 122, do: [head + n - 26 | caesar(tail, n)]
end
