defmodule Workbench.Garage.Container do
  use Ecto.Schema
  import Ecto.Changeset

  schema "containers" do
    field :name, :string
    field :type, :string
    field :description, :string
    field :location_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(container, attrs) do
    container
    |> cast(attrs, [:location_id, :name, :description, :type])
    |> validate_required([:location_id, :name, :description, :type])
  end
end
