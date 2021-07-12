defmodule Foodie.User do
  import Ecto.Query, warn: false
  #import Bcrypt_elixir bcrypt elixir is requesting for nmake
  alias Foodie.Repo
  alias Foodie.Schemas.User


  def get(user_id) do
    Repo.get(User, user_id)
  end

  def get(_user_id, _opts) do
    # opts could be a preload.
  end

  def assert_user(_user) do
    #compares user paswords
    {:ok, true}
    # case Argon2.check_pass(user, password) do
    #   true ->
    #     {:ok, true}
    #   false ->
    #     {:ok, false}
    # end

  end

  def get_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def create_tokens(user) do
    #create a new token on every login
    IO.inspect(user.id)
    %{
      accessToken: Foodie.AccessToken.generate_and_sign!(%{"userId" => user.id}),
      refreshToken:
        Foodie.RefreshToken.generate_and_sign!(%{
          "userId" => user.id,
          "tokenVersion" => 1
        })
    }
  end

  def create_new_user(user)do
    {:create,
       Repo.insert!(
         %User{
           username: user.username,
           email: if(user.email == "", do: nil, else: user.email),
           password: user.password,
           first_name: user.firstname,
           last_name: user.lastname,
           role: user.role,
         },
         returning: true
       )}
  end
  #nmake causing issues
  # defp hash_user_password(password) do
  #   Argon2.hash_pwd_salt(password)
  # end

  #user sends token,
  def tokens_to_user_id(access_token!, refresh_token) do
    access_token! = access_token! || ""

    case Foodie.AccessToken.verify_and_validate(access_token!) do
      {:ok, claims} ->
        {:existing_claim, claims["userId"]}

      _ ->
        verify_refresh_token(refresh_token)
    end
  end

#@spec verify_refresh_token(String.t()) :: new_token_result() | nil
  defp verify_refresh_token(refresh_token!) do
    refresh_token! = refresh_token! || ""

    case Foodie.RefreshToken.verify_and_validate(refresh_token!) do
      {:ok, refreshClaims} ->
        user = Foodie.Repo.get(User, refreshClaims["userId"])

        if user do
          {:new_tokens, user.id, create_tokens(user), user}
        end

      _ ->
        nil
    end
  end

end
