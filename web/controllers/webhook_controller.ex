defmodule EmailReports.WebhookController do
  use EmailReports.Web, :controller

  alias EmailReports.Webhook

  def handle(conn, params) do
    {:ok, req_id} = to_binary_uuid params["request_identifier"]
    changeset = Webhook.changeset(%Webhook{account_id: params["account"]["id"]}, %{params | "request_identifier" => req_id})
    case Repo.insert(changeset) do
      {:ok, _webhook} ->
        send_resp(conn, 200, "")
      {:error, changeset} ->
        send_resp(conn, 500, inspect changeset.errors)
    end
  end

  defp to_binary_uuid(request_identifier) do
    request_identifier
    |> String.replace("-", "")
    |> String.upcase
    |> Base.decode16
  end
end
