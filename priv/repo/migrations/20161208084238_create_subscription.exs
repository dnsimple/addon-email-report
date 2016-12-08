defmodule EmailReports.Repo.Migrations.CreateSubscription do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :account_id, :integer
      add :access_token, :string
      add :last_sent, :utc_datetime

      timestamps()
    end

  end
end
