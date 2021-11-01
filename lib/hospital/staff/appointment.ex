defmodule Hospital.Staff.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :date, :string
    field :day, :string
    field :from, :string
    field :to, :string
    field :patient_id, :id
    field :doctor_id, :id

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:from, :to, :date, :day])
    |> validate_required([:from, :to, :date, :day])
  end
end
