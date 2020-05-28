defmodule WeatherReport.Fetch do
  @root_url "https://w1.weather.gov/xml/current_obs"
  def fetch(code) when is_binary(code) do
    HTTPoison.get("#{@root_url}/#{code}.xml")
    |> check_fetch_error
  end

  def check_fetch_error(
        {:ok,
         %HTTPoison.Response{
           status_code: 200,
           body: body
         }}
      ),
      do: {:ok, body}

  def check_fetch_error({:ok, %HTTPoison.Response{status_code: status}}), do: {:error, status}

  def check_fetch_error({:error, %HTTPoison.Error{reason: reason}}), do: {:error, reason}
end
