defmodule Foodie.Plug do
  import Plug.Conn
  alias Foodie.Routes.Auth
  alias Foodie.Routes.Products
  use Plug.Router

  use Sentry.PlugCapture
  plug(Plug.Parsers,  parsers: [:json], pass: ["application/json"], json_decoder: Poison)
  plug(Foodie.Plugs.Cors)
  plug(Foodie.Metric.PrometheusExporter)
  plug(:match)
  plug(:dispatch)

  options _ do
    send_resp(conn, 200, "")
  end

  forward("/api/auth/", to: Auth)
  forward("/api/products/", to: Products)
  get _ do
    send_resp(conn, 404, "not found")
  end

  post _ do
    send_resp(conn, 404, "not found")
  end
end
