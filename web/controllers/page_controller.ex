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

    render conn, "index.html",
        email: dnsimple_account.email,
        changeset: changeset,
        subscription: Repo.get_by(Subscription, account_id: account.dnsimple_account_id)
  end

  def send(conn, %{"report_params" => %{"email" => email}}) do
    account = conn.assigns[:current_account]
    %{email: email, token: account.dnsimple_access_token}
    |> EmailReports.ReportEmail.simple
    |> EmailReports.Mailer.deliver
    conn
    |> put_flash(:info, "Mail sent to #{email}.")
    |> redirect(to: page_path(conn, :index))
  end
end
