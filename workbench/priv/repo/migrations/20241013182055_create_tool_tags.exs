defmodule Workbench.Repo.Migrations.CreateToolTags do
  use Ecto.Migration

  def change do
    create table(:tool_tags) do
      add :tool_id, references(:tools, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:tool_tags, [:tool_id, :tag_id])
  end
end
