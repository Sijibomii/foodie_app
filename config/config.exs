# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :foodie, ecto_repos: [Foodie.Repo]

# Configures the endpoint
# config :url, [host: "localhost"],
#   secret_key_base: "Wn/8/9b0wj2quK/rxCJhTGtQOGdam8u7XSaHN+/ZV1LrgZyUjcPr22GAKbvNJ5Ra",
#   pubsub_server: Foodie.PubSub,
#   live_view: [signing_salt: "N8HKMr+L"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
# config :phoenix, :json_library, Jason

# config :phoenix, :format_encoders,
#   "json-api": Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
