defmodule EmailReports.PageController do
  use EmailReports.Web, :controller

  plug EmailReports.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]
    |> EmailReports.Dnsimple.whoami
    |> Map.get(:account)

    render conn, "index.html", email: account.email
  end

  def send(conn, %{"report_params" => %{"email" => email}}) do
    EmailReports.ReportEmail.simple(%{email: email})
    |> EmailReports.Mailer.deliver
    conn
    |> put_flash(:info, "Mail sent to #{email}.")
    |> redirect(to: page_path(conn, :index))
  end
end
