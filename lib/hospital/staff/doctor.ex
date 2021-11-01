defmodule Hospital.Staff.Doctor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "doctors" do
    field :active, :boolean, default: false
    field :name, :string
    field :speciality, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(doctor, attrs) do
    doctor
    |> cast(attrs, [:name, :speciality, :active, :user_id])
    |> validate_required([:name, :speciality, :active, :user_id])
  end
end
