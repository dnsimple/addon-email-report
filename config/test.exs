use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :email_reports, EmailReports.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :email_reports, EmailReports.Repo,
  adapter: Ecto.Adapters.Postgres,
  # username: "postgres",
  # password: "postgres",
  database: "email_reports_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure 3rd parties
config :email_reports,
  dnsimple_client_id: "some-id",
  dnsimple_client_secret: "some-access-token"

config :email_reports, EmailReports.Mailer,
  adapter: Swoosh.Adapters.Test

# Configure mocks
config :email_reports,
  dnsimple_oauth_service: EmailReports.Dnsimple.OauthMock,
  dnsimple_identity_service: EmailReports.Dnsimple.IdentityMock,
  dnsimple_domains_service: EmailReports.Dnsimple.DomainsMock,
  dnsimple_domain_certificates_service: EmailReports.Dnsimple.CertificatesMock,
  digitalocean_oauth_service: EmailReports.DigitalOcean.OauthMock

config :email_reports, did_you_know: [ ~s(that randomness in tests sucks?)]
