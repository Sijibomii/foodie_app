defmodule Foodie.Schemas.CouponPass do
  use Ecto.Schema
  import Ecto.Changeset
  alias Foodie.Schemas.User
  alias Foodie.Schemas.Coupon
  #for private coupons
  schema "coupon_pass" do
    belongs_to :user, User
    belongs_to :coupon, Coupon
  end

  def changeset(pass, attrs) do
    pass
    |> cast(attrs, [:user, :coupon ])
    |> validate_required([
      :user, :coupon
    ])

  end
end
