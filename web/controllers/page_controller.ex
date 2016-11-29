defmodule EmailReports.PageController do
  use EmailReports.Web, :controller

  plug EmailReports.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]
    IO.inspect EmailReports.Dnsimple.domains(account)
    EmailReports.ReportEmail.simple(%{name: "Ole Michaelis", email: "Ole.Michaelis@gmail.com", username: "nesQuick"})
    |> EmailReports.Mailer.deliver
    render conn, "index.html"
  end
end
