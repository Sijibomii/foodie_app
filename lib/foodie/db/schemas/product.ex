defmodule Foodie.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foodie.Schemas.Category
  schema "products" do
    field :name, :string
    belongs_to :category, Category
    field :main_image_url, :string
    field :price_naira, :integer
    field :quantity, :integer
    field :isAvalable, :boolean, default: false
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :category_id, :main_image_url, :price_naira, :quantity, :description])
    |> validate_required([
      :name, :category_id, :main_image_url, :price_naira, :quantity, :description
    ])
  end
end
