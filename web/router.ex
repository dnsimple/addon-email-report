defmodule EmailReports.Router do
  use EmailReports.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EmailReports do
    pipe_through :browser # Use the default browser stack

    get "/dnsimple/authorize", DnsimpleOauthController, :new
    get "/dnsimple/callback", DnsimpleOauthController, :create

    get "/", PageController, :index
    post "/", PageController, :send

    post "/logout", LogoutController, :logout
    get "/bye", LogoutController, :bye

    post "/notify", WebhookController, :handle

    resources "/subscriptions", SubscriptionController, only: [:create, :delete]
  end

  if Mix.env == :dev do
    forward "/mailbox", Plug.Swoosh.MailboxPreview, [base_path: "/mailbox"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", EmailReports do
  #   pipe_through :api
  # end
end
