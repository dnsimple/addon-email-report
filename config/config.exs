# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :email_reports,
  ecto_repos: [EmailReports.Repo]

# Configures the endpoint
config :email_reports, EmailReports.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c1dTMaoBowi5d1GEbG14Ox/EhPTupQLk/KUpphwvcuMefN2PANCkZtdYD2yvRbV4",
  render_errors: [view: EmailReports.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EmailReports.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure E-Mail reports
config :email_reports,
  report_from: {"Trusty form DNSimple", "trusty@dnsimple.com"},
  report_reply_to: {"DNSimple Support", "support@dnsimple.com"}


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
