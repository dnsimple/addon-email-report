defmodule EmailReports.Repo.Migrations.CreateWebhook do
  use Ecto.Migration

  def change do
    create table(:webhooks, primary_key: false) do
      add :request_identifier, :binary_id, primary_key: true
      add :account_id, :integer
      add :name, :string
      add :data, :map
      add :account, :map
      add :actor, :map

      timestamps()
    end

  end
end
