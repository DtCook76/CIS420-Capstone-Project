defmodule Workbench.Repo.Migrations.AddUserIdToTool do
  use Ecto.Migration

  def change do
    alter table(:tools) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:tools, [:user_id])
  end
end
