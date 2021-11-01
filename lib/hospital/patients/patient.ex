defmodule Hospital.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
    field :age, :integer
    field :disease, :string
    field :gender, :string
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:name, :disease, :gender, :age, :user_id])
    |> validate_required([:name, :disease, :gender, :age, :user_id])
  end
end
