defmodule EmailReports.PageController do
  use EmailReports.Web, :controller

  alias EmailReports.Subscription

  plug EmailReports.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]
    dnsimple_account = account
    |> EmailReports.Dnsimple.whoami
    |> Map.get(:account)

    changeset = Subscription.changeset(%Subscription{
        account_id: account.dnsimple_account_id,
        access_token: account.dnsimple_access_token
    })

    render conn, "index.html", email: dnsimple_account.email, changeset: changeset
  end

  def send(conn, %{"report_params" => %{"email" => email}}) do
    account = conn.assigns[:current_account]
    EmailReports.ReportEmail.simple(%{email: email, token: account.dnsimple_access_token})
    |> EmailReports.Mailer.deliver
    conn
    |> put_flash(:info, "Mail sent to #{email}.")
    |> redirect(to: page_path(conn, :index))
  end
end
