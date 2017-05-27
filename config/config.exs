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

# Configures Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Podcasts",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "Zc1Tun16EzNSXjr8vEHpJ14znTPD5QwW4uElePqFR0i0lJB9Gy7YcRnz1r7LByCR",
  serializer: Podcasts.Web.Auth.GuardianSerializer

config :junit_formatter,
  report_file: "tests_report.xml",
  report_dir: ".",
  print_report_file: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
