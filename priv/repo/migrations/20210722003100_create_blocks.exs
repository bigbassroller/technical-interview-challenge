defmodule VetspireApp.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks) do
      add :name, :string
      add :description, :string
      add :image, :string

      add :block_type_id, references(:block_types, on_delete: :nothing)

      timestamps()
    end

    create index(:blocks, [:block_type_id])
  end
end
