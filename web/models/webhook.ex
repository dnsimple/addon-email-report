defmodule EmailReports.Webhook do
  use EmailReports.Web, :model

  @primary_key {:request_identifier, :string, autogenerate: false}

  schema "webhooks" do
    # field :request_identifier, :string, primary_key: true
    field :account_id, :integer
    field :name, :string
    field :data, :map
    field :account, :map
    field :actor, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:request_identifier, :account_id, :name, :data, :account, :actor])
    |> validate_required([:request_identifier, :account_id, :name, :data, :account, :actor])
  end
end
