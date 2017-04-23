# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :podcasts,
  ecto_repos: [Podcasts.Repo]

# Configures the endpoint
config :podcasts, Podcasts.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NuJ4wCkscB3oDhtjHPDH9hU9E0GMtZI9d3Bk6+jl3U5MtrCpK0xKo+jTd1kh7PIs",
  render_errors: [view: Podcasts.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Podcasts.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
