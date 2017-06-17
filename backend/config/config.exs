# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sonic_cat,
  ecto_repos: [SonicCat.Repo]

# Configures the endpoint
config :sonic_cat, SonicCat.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iFbRvhNz4if0MR92A2AJUcljgpLQ3/oz4L0Rt2ZnM5dDs3denszLNRb6Y5DufRCS",
  render_errors: [view: SonicCat.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SonicCat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
