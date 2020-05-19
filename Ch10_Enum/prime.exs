defmodule MyList do
  def span(to, to), do: [to]
  def span(next, to), do: [next | span(next + 1, to)]
end

defmodule Prime do
  import MyList, only: [span: 2]

  def generate(n) when is_integer(n) and n >= 2 do
    for x <- span(2, n), x == 2 or rem(x, 2) > 0, do: x
  end
end
