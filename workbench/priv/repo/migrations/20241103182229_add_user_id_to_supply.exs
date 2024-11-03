defmodule Workbench.Repo.Migrations.AddUserIdToSupply do
  use Ecto.Migration

  def change do
    alter table(:supplies) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:supplies, [:user_id])
  end
end
