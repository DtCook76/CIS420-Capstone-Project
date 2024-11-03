defmodule Workbench.Items.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tools" do
    field :name, :string
    field :description, :string
    field :image_url, :string
    field :container_id, :id
    belongs_to :user, Workbench.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:name, :description, :image_url, :user_id])
    |> validate_required([:name, :description, :image_url])
  end
end
