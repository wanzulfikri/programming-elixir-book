use Mix.Config
import_config "#{Mix.env()}.exs"
config :issues, github_url: "https://api.github.com"

config :logger,
  compile_time_purge_level: :info
