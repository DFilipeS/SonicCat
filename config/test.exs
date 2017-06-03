use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :podcasts, Podcasts.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :junit_formatter,
  report_file: "tests_report.xml",
  report_dir: ".",
  print_report_file: true

# Configure your database
config :podcasts, Podcasts.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "podcasts_test",
  hostname: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
