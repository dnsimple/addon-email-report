defmodule EmailReports.PageControllerTest do
  use EmailReports.ConnCase

  import Swoosh.TestAssertions

  setup %{conn: conn} do
   conn = assign(conn, :current_account, %{
     :dnsimple_access_token => "anytoken",
     :dnsimple_account_id => "1234",
   })
   {:ok, conn: conn}
 end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Subscribe to your Monthly DNSimple report with user@example.com!"
  end

  test "POST /", %{conn: conn} do
    email = "user2@example.com"

    conn = post conn, "/", %{"report_params" => %{"email" => email}}

    assert_email_sent EmailReports.ReportEmail.simple(%{email: email, token: "anytoken"})
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
