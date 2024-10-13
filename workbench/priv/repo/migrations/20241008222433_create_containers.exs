defmodule Workbench.Repo.Migrations.CreateContainers do
  use Ecto.Migration

  def change do
    create table(:containers) do
      add :name, :string
      add :description, :text
      add :type, :string
      add :location_id, references(:locations, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:containers, [:location_id])
  end
end
