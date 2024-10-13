defmodule Workbench.Items.Supply do
  use Ecto.Schema
  import Ecto.Changeset

  schema "supplies" do
    field :name, :string
    field :description, :string
    field :quantity, :integer
    field :restock_link, :string
    field :image_url, :string
    field :price, :decimal
    field :container_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(supply, attrs) do
    supply
    |> cast(attrs, [:name, :description, :quantity, :restock_link, :image_url, :price])
    |> validate_required([:name, :description, :quantity, :restock_link, :image_url, :price])
  end
end
