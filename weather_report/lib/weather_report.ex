defmodule WeatherReport do
  import WeatherReport.Fetch, only: [fetch: 1]

  @moduledoc """
  Documentation for `WeatherReport`.
  """

  def weather(code) do
    fetch(code)
    # |> handle_response
  end
end
