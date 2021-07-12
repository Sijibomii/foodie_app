defmodule Foodie.Routes.Products do
  import Plug.Conn
  use Plug.Router
  alias Foodie.Products
  require Logger

  plug(:match)
  plug(:dispatch)

  #get all id
  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      200,
      Poison.encode!(%{products: Products.all_products()})
    )
  end


  get "/:id" do
    %Plug.Conn{params: %{"id" => id}} = conn
    case Products.get_product_by_id(id) do
      {:ok, products}->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Poison.encode!(%{product: products})
        )

      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Poison.encode!(%{error: "product not found!"})
        )
    end
  end

  #admin create product
  # post "/admin/" do

  # end
  #admin update product

  #admin delete product

end
