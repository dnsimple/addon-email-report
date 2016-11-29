defmodule EmailReports.PageControllerTest do
  use EmailReports.ConnCase

  setup %{conn: conn} do
   conn = assign(conn, :current_account, %{
     :dnsimple_access_token => "anytoken",
     :dnsimple_account_id => "1234",
   })
   {:ok, conn: conn}
 end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
