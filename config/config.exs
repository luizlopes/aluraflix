# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :aluraflix,
  ecto_repos: [Aluraflix.Repo]

# Configures the endpoint
config :aluraflix, AluraflixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IbFKK1v+4zu7srcwz4t9jAi5JBV81r/XJslikzgHQFJzFqCt9wYFRj4tB7zVhykU",
  render_errors: [view: AluraflixWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Aluraflix.PubSub,
  live_view: [signing_salt: "Ao38tGwi"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
