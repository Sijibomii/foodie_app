defmodule Foodie.Schemas.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do

    field :quantity, :integer
    belongs_to :product, Foodie.Schemas.Product
    belongs_to :order, Foodie.Schemas.Orders

    timestamps()
  end
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:quantity, :product_id, :order_id])
    |> validate_required([
      :quantity, :product_id, :order_id
    ])
    #|> set_name_if_anonymous()
  end
end
