defmodule Foodie.Products do
  #import Ecto.Query
  alias Foodie.Repo
  alias Foodie.Schemas.Product

  def all_products() do
    Repo.all(Product)
  end

  def get_product_by_id(id), do: Repo.get_by(Product, id: id)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
end
