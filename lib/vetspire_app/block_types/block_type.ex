defmodule VetspireApp.BlockTypes.BlockType do
  use Ecto.Schema
  import Ecto.Changeset

  alias VetspireApp.BlockTypes.Block

  schema "block_types" do
    field :description, :string
    field :name, :string

    has_many :blocks, Block, on_replace: :delete_if_exists

    timestamps()
  end

  @doc false
  def changeset(block_type, attrs) do
    block_type
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
