defmodule EmailReports.Subscription do
  use EmailReports.Web, :model

  schema "subscriptions" do
    field :account_id, :integer
    field :access_token, :string
    field :last_sent, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:account_id, :access_token, :last_sent])
    |> validate_required([:account_id, :access_token])
  end
end
