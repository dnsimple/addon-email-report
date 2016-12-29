defmodule EmailReports.LogoutController do
  use EmailReports.Web, :controller

  def logout(conn, _params) do
    conn
    |> clear_session
    |> redirect(to: logout_path(conn, :bye))
  end

  def bye(conn, _params) do
    render(conn, "bye.html")
  end
end
