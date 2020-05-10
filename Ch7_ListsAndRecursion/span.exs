defmodule MyList do
  def span([_, to], to), do: [to]
  def span([_from, next], to), do: [next | span([next, next + 1], to)]
  def span(from, to), do: [from | span([from, from + 1], to)]
end
