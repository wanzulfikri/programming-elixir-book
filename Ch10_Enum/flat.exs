defmodule MyList do
  def flatten([head | tail]) do
    [flatten(head, []) | flatten(tail, [])]
  end

  def flatten([head | []], current_list) do
    IO.puts(current_list)
    current_list
  end

  def flatten([head | tail], []) do
    [flatten(head, [head]) | flatten(tail, [])]
  end

  def flatten([head | tail], current_list) do
    [flatten(head, [head | current_list]) | flatten(tail, [])]
  end

  def flatten(el, _) do
    el
  end

  def flattenz(list) when is_list(list) do
    Enum.reverse(flattenz(list, []))
  end

  def flattenz([], acc) do
    acc
  end

  def flattenz([head | tail], acc) do
    flattenz(tail, flattenz(head, acc))
  end

  def flattenz(single, acc) do
    [single | acc]
  end
end
