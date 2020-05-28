defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_descending_order: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "count is defaulted if two values given" do
    assert parse_args(["user", "project"]) == {"user", "project", 4}
  end

  test "sort descending orders the correct way" do
    result = sort_into_descending_order(fake_created_at_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues == ~w{c b a}
  end

  defp fake_created_at_list(values) do
    for value <- values,
        do: %{"created_at" => value, "other_data" => "xxx"}
  end

  @doc """
  Issues formatted as a table

  # | created_at             | title
  ----+----------------------+----------------------------------------
  889 | 2013-03-16T22:03:13Z | MIX_PATH environment variable (of sorts)
  892 | 2013-03-20T19:22:07Z | Enhanced mix test --cover
  893 | 2013-03-21T06:23:00Z | mix test time reports
  898 | 2013-03-23T19:19:08Z | Add mix compile --warnings-as-errors

  """
end
