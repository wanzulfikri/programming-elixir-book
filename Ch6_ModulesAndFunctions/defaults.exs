defmodule Defaults do
  def foo(a, b \\ false)
  def foo(true, b), do: b
  def foo(false, b), do: b
end
