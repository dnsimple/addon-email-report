defmodule EmailReports.SubscriptionController do
  use EmailReports.Web, :controller

  alias EmailReports.Subscription

  def create(conn, %{"subscription" => subscription_params}) do
    changeset = Subscription.changeset(%Subscription{}, subscription_params)

    case Repo.insert(changeset) do
      {:ok, _subscription} ->
        conn
        |> put_flash(:info, "Subscription created successfully. You will receive your first report shortly.")
        |> redirect(to: page_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Subscription could not be created.")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    subscription = Repo.get!(Subscription, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(subscription)

    conn
    |> put_flash(:info, "Subscription deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
