defmodule Foodie.Schemas.Coupon do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foodie.Schemas.Category
  schema "coupon" do
    field :description, :string
    field :tag, :string
    field :code, :string
    field :current_uses, :integer, default: 0
    field :max_uses, :integer, default: 1000
    field :percent_discount, :integer
    field :expires, :date
    field :is_active, :boolean, default: false
    belongs_to :category, Category
    field :isPublic, :boolean, default: false

    timestamps()
  end
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:description, :tag, :code, :percent_discount, :expires, :category ])
    |> validate_required([
      :description, :tag, :code, :percent_discount, :expires, :category
    ])
    |> unique_constraint([:tag, :code])
  end
end
