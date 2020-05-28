defmodule WeatherReport.FetchTest do
  use ExUnit.Case
  import WeatherReport.Fetch, only: [fetch: 1]

  describe "fetch/1" do
    test "returns {:ok, body} if response status code is 200" do
      assert {:ok, _} = fetch("PADK")
    end

    test "returns {:error, body} if response status code is 200 or response is %HTTPoison.Error" do
      assert {:error, _} = fetch("PAD")
    end
  end
end
