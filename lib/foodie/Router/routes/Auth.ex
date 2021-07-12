defmodule Foodie.Routes.Auth do
  import Plug.Conn
  use Plug.Router

  alias Foodie.User

  require Logger

  plug(:match)
  plug(:dispatch)

  post "/login" do
    #consifrm post routes i don't think this should be params
    data= conn.body_params
    %{"password" => password, "username" => username }=data
    case User.get_by_username(username) do
      nil -> conn
      |> put_resp_content_type("application/json")
      |> send_resp(
        200,
        Poison.encode!(%{error: "invalid login details"})
      )
      user-> IO.inspect("got a user")
      case User.assert_user(%{
        username: username,
        password: password,
      }) do
        {:ok, true} ->
          #do token stuff here, return access token and refresh token
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(
            200,
            Poison.encode!(%{tokens: User.create_tokens(user)})
          )
        _ ->
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(
            200,
            Poison.encode!(%{error: "invalid login details"})
          )
      end

    end
  end

#   {:ok, tokens} ->

#   _->
#    conn
#    |> put_resp_content_type("application/json")
#    |> send_resp(
#      200,
#      Poison.encode!(%{error: "auth failed"})
#    )
#  end
  #sign up
  post "/signup" do
    data= conn.body_params
    %{"email" => email, "firstname" => firstname,
     "lastname" => lastname, "password" => password, "username" => username }=data
    case User.get_by_username(username) do
      {:ok, _user}-> #username already exist
        IO.inspect("error")
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          200,
          Poison.encode!(%{error: "username taken"})
        )
      _ -> case User.create_new_user(%{
        username: username,
        password: password,
        email: email,
        firstname: firstname,
        lastname: lastname,
        role: "customer" #if (data.role , do: data.role, else: "customer")
      }) do
        {:create, user_new} ->
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(
            200,
            Poison.encode!(%{signup: user_new, tokens: User.create_tokens(user_new)})
          )

        _ ->
          IO.inspect("error")
          conn
          |> put_resp_content_type("application/json")
          |> send_resp(
            200,
            Poison.encode!(%{error: "signup failed"})
          )
      end
    end
  end

  # #admin only routs
  # put "/admin/:id" do
  #   #used to change the role of a particular user
  # end

  # delete "/admin/:id" do
  #   #delete a user
  # end
end
