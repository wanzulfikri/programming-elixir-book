defmodule OK do
  def ok!({:ok, data}), do: data

  def ok!({_, info}) do
    raise "Not okay: #{info}"
  end

  def ok!(_) do
    raise "Not okay"
  end
end
