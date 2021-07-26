defmodule VetspireApp.Repo.Migrations.CreateBlockTypes do
  use Ecto.Migration

  def change do
    create table(:block_types) do
      add :name, :string
      add :description, :string

      timestamps()
    end

    create unique_index(:block_types, :name)

  end
end
