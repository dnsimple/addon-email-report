defmodule EmailReports.WebhookController do
  use EmailReports.Web, :controller

  alias EmailReports.Webhook

  def handle(conn, params) do
    # This hack can be deleted as soon as this PR gets merged and released:
    # https://github.com/elixir-ecto/postgrex/pull/271
    # Then you'd have: changeset = Webhook.changeset(%Webhook{account_id: params["account"]["id"]}, params)
    {:ok, req_id} = params["request_identifier"] |> String.replace("-", "") |> String.upcase |> Base.decode16
    changeset = Webhook.changeset(%Webhook{account_id: params["account"]["id"]}, %{params | "request_identifier" => req_id})
    case Repo.insert(changeset) do
      {:ok, _webhook} ->
        send_resp(conn, 200, "")
      {:error, changeset} ->
        send_resp(conn, 500, inspect changeset.errors)
    end
  end


end
