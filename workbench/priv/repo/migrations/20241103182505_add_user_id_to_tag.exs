defmodule Workbench.Repo.Migrations.AddUserIdToTag do
  use Ecto.Migration

  def change do
    alter table(:tags) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:tags, [:user_id])
  end
end
