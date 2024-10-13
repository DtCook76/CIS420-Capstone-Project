defmodule Workbench.Repo.Migrations.CreateProjectTags do
  use Ecto.Migration

  def change do
    create table(:project_tags) do
      add :project_id, references(:projects, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:project_tags, [:project_id, :tag_id])
  end
end
