defmodule EmailReports.SubscriptionTest do
  use EmailReports.ModelCase

  alias EmailReports.Subscription

  @valid_attrs %{access_token: "some content", account_id: 42, last_sent: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Subscription.changeset(%Subscription{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Subscription.changeset(%Subscription{}, @invalid_attrs)
    refute changeset.valid?
  end
end
