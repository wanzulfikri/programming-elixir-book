defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_table_for_columns: 2]
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def main(argv) do
    argv
    |> parse_args()
    |> process()
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count}`, or `:help` if help was given.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  # bad arg or --help
  def args_to_internal_representation(_) do
    :help
  end

  def process(:help) do
    IO.puts("""
    usage: issues <user> <project> [ count | #{@default_count}]
    """)

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
    |> decode_response()
    |> sort_into_descending_order()
    |> last(count)
    |> print_table_for_columns(["number", "created_at", "title"])

    # pipe to format/1 to use my table format implementation
    # |> format
  end

  @doc """
  Issues formatted as a table

  #   | created_at           | title
  ----+----------------------+----------------------------------------
  889 | 2013-03-16T22:03:13Z | MIX_PATH environment variable (of sorts)
  892 | 2013-03-20T19:22:07Z | Enhanced mix test --cover
  893 | 2013-03-21T06:23:00Z | mix test time reports
  898 | 2013-03-23T19:19:08Z | Add mix compile --warnings-as-errors

  """

  def format(list) do
    list
    |> cols_lengths()
    |> formatAll
  end

  defp formatAll({issues, cols_lengths}) do
    printHeader(cols_lengths)
    Enum.map(issues, &printLine(&1, cols_lengths))
  end

  defp printHeader(cols_lengths) do
    printLine(["#", "created_at", "title"], cols_lengths)
    printLine(["", "", ""], cols_lengths, "+", "-")
  end

  defp printLine(issue, cols_lengths, divider \\ "|", padding \\ " ")

  defp printLine(
         %{"number" => number, "created_at" => created_at, "title" => title},
         cols_lengths,
         divider,
         padding
       ) do
    number = Integer.to_string(number)
    printLine([number, created_at, title], cols_lengths, divider, padding)
  end

  defp printLine(
         [first, second, third],
         %{
           number: number_length,
           created_at: created_at_length,
           title: title_length
         },
         divider,
         padding
       ) do
    IO.write("#{String.pad_trailing(first, number_length, padding)} #{divider} ")
    IO.write("#{String.pad_trailing(second, created_at_length, padding)} #{divider} ")
    IO.write("#{String.pad_trailing(third, title_length, padding)}")
    IO.puts("")
  end

  defp cols_lengths(list) when is_list(list) do
    Enum.map_reduce(list, %{number: 0, created_at: 0, title: 0}, fn issue, max_lengths ->
      %{"number" => number, "created_at" => created_at, "title" => title} = issue
      stringNumber = Integer.to_string(number)

      {issue,
       %{
         number: maxStringLength(stringNumber, max_lengths.number),
         created_at: maxStringLength(created_at, max_lengths.created_at),
         title: maxStringLength(title, max_lengths.title)
       }}
    end)
  end

  defp maxStringLength(first, second) when is_binary(first) and is_integer(second) do
    max(String.length(first), second)
  end

  def last(list, count) do
    list
    |> Enum.take(count)
    |> Enum.reverse()
  end

  def sort_into_descending_order(list_of_issues) do
    list_of_issues
    |> Enum.sort(fn i1, i2 ->
      i1["created_at"] >= i2["created_at"]
    end)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from Github: #{error["message"]}")
    System.halt(2)
  end
end
