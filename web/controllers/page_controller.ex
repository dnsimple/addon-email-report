defmodule EmailReports.PageController do
  use EmailReports.Web, :controller

  plug EmailReports.Plug.CurrentAccount

  def index(conn, _params) do
    account = conn.assigns[:current_account]
    IO.inspect EmailReports.Dnsimple.domains(account)
    render conn, "index.html"
  end
end
