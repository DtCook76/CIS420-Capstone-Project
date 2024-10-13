defmodule Workbench.Repo.Migrations.CreateTools do
  use Ecto.Migration

  def change do
    create table(:tools) do
      add :name, :string
      add :description, :text
      add :image_url, :string
      add :container_id, references(:containers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:tools, [:container_id])
  end
end
