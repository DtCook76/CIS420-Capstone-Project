defmodule Workbench.Repo.Migrations.CreateSupplies do
  use Ecto.Migration

  def change do
    create table(:supplies) do
      add :name, :string
      add :description, :text
      add :quantity, :integer
      add :restock_link, :string
      add :image_url, :string
      add :price, :decimal
      add :container_id, references(:containers, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:supplies, [:container_id])
  end
end
