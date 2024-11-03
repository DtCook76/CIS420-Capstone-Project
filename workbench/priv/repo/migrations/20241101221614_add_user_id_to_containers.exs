defmodule Workbench.Repo.Migrations.AddUserIdToContainers do
  use Ecto.Migration

  def change do
    alter table(:containers) do
      add :user_id, references(:users, on_delete: :delete_all)
    end

    create index(:containers, [:user_id])
  end
end
