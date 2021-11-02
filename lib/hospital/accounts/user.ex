defmodule Hospital.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :provider, :string, default: "self"
    field :token, :string, default: "no-token"
    field :password, :string
    field :type, :string, default: "patient"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token, :password, :type])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_required([:email, :password, :type])
  end
end
