defmodule Enumb do
  def all?(list, fun \\ &(!!&1))

  def all?([], _) do
    true
  end

  def all?([head | tail], fun) do
    case fun.(head) do
      false -> false
      true -> all?(tail, fun)
    end
  end

  def each([], _) do
    []
  end

  def each([head | tail], fun) do
    [fun.(head) | each(tail, fun)]
  end

  def filter([], _), do: []

  def filter([head | tail], fun) do
    case fun.(head) do
      true -> [head | filter(tail, fun)]
      false -> filter(tail, fun)
    end
  end

  def list_length([], length), do: length

  def list_length([_head | tail], length) do
    list_length(tail, length + 1)
  end

  def list_length([_head | tail]) do
    list_length(tail, 1)
  end

  def reverse_list([]) do
	[]
  end
  def reverse_list([head|tail]) do
	reverse_list(tail) ++ [head]
  end
  def split(list, 0) do
    {[], list}
  end

  def split(list, count) when is_integer(count) and count < 0 do
    new_count = list_length(list) + count
    IO.puts(new_count)

    case new_count > 0 do
      true -> split(list, new_count)
      false -> split(list, 0)
    end
  end

  def split([head | tail], count) when is_integer(count) do
    split([head], tail, count - 1)
  end

  def split(first_part, [], _) do
    {first_part, []}
  end

  def split(first_part, second_part, 0) do
    {first_part, second_part}
  end

  def split(first_part, [head | tail] = _second_part, count) do
    split(first_part ++ [head], tail, count - 1)
  end

  def take(_, 0) do
    []
  end

  def take([], _) do
    []
  end
  def take(list, count) when is_integer(count) and count < 0 do
    take(reverse_list(list), -count)
  end

  def take([head | tail], count) when is_integer(count) do
    [head | take(tail, count - 1)]
  end
end
