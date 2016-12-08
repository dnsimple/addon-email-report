defmodule EmailReports.PageControllerTest do
  use EmailReports.ConnCase

  import Swoosh.TestAssertions
  alias EmailReports.Subscription

  setup %{conn: conn} do
   conn = assign(conn, :current_account, %{
     :dnsimple_access_token => "anytoken",
     :dnsimple_account_id => "1234",
   })
   {:ok, conn: conn}
 end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Your personal regular DNSimple report!"
  end

  test "shows subscribe form when no active subscription exists", %{conn: conn} do
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Subscribe"
  end

  test "shows unsubscribe when a active subscription exists", %{conn: conn} do
    account_id = String.to_integer conn.assigns[:current_account].dnsimple_account_id
    subscription = Repo.insert! %Subscription{account_id: account_id}
    conn = get conn, page_path(conn, :index)
    assert html_response(conn, 200) =~ "Unsubscribe"
  end

  test "POST /", %{conn: conn} do
    email = "user2@example.com"

    conn = post conn, "/", %{"report_params" => %{"email" => email}}

    assert_email_sent EmailReports.ReportEmail.simple(%{email: email, token: "anytoken"})
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
