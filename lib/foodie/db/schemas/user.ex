defmodule Foodie.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :username, :string
    field :password, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :role, :string #check how to make an enum either managar, cook, customer or driver
    field :is_admin, :boolean, default: false

    timestamps()
  end


  # def set_name_if_anonymous(changeset) do
  #   name = get_field(changeset, :name)

  #   if is_nil(name) do
  #     put_change(changeset, :name, "Anonymous")
  #   else
  #     changeset
  #   end
  # end
  # defp put_pass_hash(%Ecto.Changeset{valid?: true, changes:
  #   %{password: password}} = changeset) do
  #   change(changeset, add_hash(password))
  # end

  # defp put_pass_hash(changeset), do: changeset


  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email, :role])
    |> validate_required([
      :username, :password, :email, :role
    ])
    |> unique_constraint([:email, :username])
    #|> put_pass_hash()
  end
end
