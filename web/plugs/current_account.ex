defmodule EmailReports.Plug.CurrentAccount do
  import Plug.Conn
  require Logger

  def init(opts), do: opts

  def call(conn, _opts) do
    case current_account(conn) do
      %{ :dnsimple_access_token => nil } ->
        conn
        |> Phoenix.Controller.redirect(to: EmailReports.Router.Helpers.dnsimple_oauth_path(conn, :new))
        |> halt
      account -> assign(conn, :current_account, account)
    end
  end

  def current_account(conn) do
    case conn.assigns[:current_account] do
      nil -> build_account(conn)
      account -> account
    end
  end

  def build_account(conn) do
    %{
      :dnsimple_access_token => get_session(conn, :dnsimple_access_token),
      :dnsimple_account_id => get_session(conn, :dnsimple_account_id),
    }
  end
end
