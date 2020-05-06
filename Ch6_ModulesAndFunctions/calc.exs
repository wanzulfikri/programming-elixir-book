defmodule Calc do
  def sum(0), do: 0
  def sum(n), do: n + sum(n - 1)

  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))

  def getGuessNum(range) do
    _first..last = range
    count = Enum.count(range)
    last - div(count, 2)
  end

  def guess2(actual, range \\ 1..1000) when is_map(range) and is_integer(actual) do
    guessNum = getGuessNum(range)
    first..last = range
    IO.puts("Is it #{guessNum}?")
    if guessNum == actual, do: IO.puts(guessNum)
    if guessNum > actual, do: guess2(actual, first..guessNum)
    if guessNum < actual, do: guess2(actual, guessNum..last)
  end

  def guess(actual, range = min..max \\ 1..1000) when is_map(range) and is_integer(actual) do
    guessNum = div(min + max, 2)
    IO.puts("Is it #{guessNum}?")
    guess(actual, range, guessNum)
  end

  def guess(actual, _, actual), do: actual

  def guess(actual, _min..max, guessNum) when guessNum < actual, do: guess(actual, guessNum..max)

  def guess(actual, min.._max, guessNum) when guessNum > actual, do: guess(actual, min..guessNum)
end
