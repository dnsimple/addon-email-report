defmodule EmailReports.WebhookTest do
  use EmailReports.ModelCase

  alias EmailReports.Webhook

  @valid_attrs %{account: %{}, account_id: 42, actor: %{}, data: %{}, name: "some content", request_identifier: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Webhook.changeset(%Webhook{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Webhook.changeset(%Webhook{}, @invalid_attrs)
    refute changeset.valid?
  end
end
