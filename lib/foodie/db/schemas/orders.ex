defmodule Foodie.Schemas.Orders do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foodie.Schemas.User
  #would be used as cart too, once user pays it becomes a registered oreder
  schema "orders" do
    #TODO: create a struct that houses the status of order
    field :paid, :boolean, default: false
    field :delivered, :boolean, default: false
    belongs_to :driver, User
    field :processed, :boolean, default: false
    belongs_to :customer, User

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:customer])
    |> validate_required([
      :customer
    ])
  end
end
