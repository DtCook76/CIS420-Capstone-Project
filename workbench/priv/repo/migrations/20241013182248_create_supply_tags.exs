defmodule Workbench.Repo.Migrations.CreateSupplyTags do
  use Ecto.Migration

  def change do
    create table(:supply_tags) do
      add :supply_id, references(:supplies, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:supply_tags, [:supply_id, :tag_id])
  end
end
