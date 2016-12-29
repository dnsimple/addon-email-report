defmodule EmailReports.SubscriptionControllerTest do
  use EmailReports.ConnCase

  alias EmailReports.Subscription
  @valid_attrs %{access_token: "some content", account_id: 42, last_sent: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, subscription_path(conn, :create), subscription: @valid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert Repo.get_by(Subscription, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, subscription_path(conn, :create), subscription: @invalid_attrs
    assert redirected_to(conn) == page_path(conn, :index)
    assert get_flash(conn, :error) == "Subscription could not be created."
  end

  test "deletes chosen resource", %{conn: conn} do
    subscription = Repo.insert! %Subscription{}
    conn = delete conn, subscription_path(conn, :delete, subscription)
    assert redirected_to(conn) == page_path(conn, :index)
    refute Repo.get(Subscription, subscription.id)
  end
end
