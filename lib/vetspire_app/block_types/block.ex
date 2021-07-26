defmodule VetspireApp.BlockTypes.Block do
  use Ecto.Schema
  import Ecto.Changeset

  alias VetspireApp.BlockTypes.BlockType

  schema "blocks" do
    field :description, :string
    field :image, :string
    field :name, :string

    belongs_to :block_type, BlockType

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:name, :description, :image, :block_type_id])
    |> validate_required([:name])
    |> foreign_key_constraint(:block_type)
  end
end
