defmodule STB do
  def is_printable?([single] = list) when is_list(list) do
    if single >= 32 and single <= 126 do
      true
    else
      false
    end
  end

  def anagram?([], _), do: true
  def anagram?(_, []), do: true

  def anagram?(word1, [head | tail] = word2) when is_list(word1) and is_list(word2) do
    case Enum.member?(word1, head) do
      true -> anagram?(List.delete(word1, head), tail)
      false -> false
    end
  end

  def calculate([head | _tail] = expressions)
      when is_list(expressions) and head not in ['+-*/'] do
    calculate(expressions, 0)
  end

  def calculate([head | tail], 0) when head in '123456789' do
    calculate(tail, head - ?0)
  end

  def calculate(_, 0) do
    raise "Invalid digit used"
  end

  def calculate([], value), do: value

  def calculate([head | tail], value) when head in '0123456789' do
    calculate(tail, value * 10 + head - ?0)
  end

  def calculate([head | tail], value) when head in '+-*/' do
    case head do
      ?+ -> value + calculate(tail, 0)
      ?- -> value - calculate(tail, 0)
      ?* -> value * calculate(tail, 0)
      ?/ -> value / calculate(tail, 0)
    end
  end
end
