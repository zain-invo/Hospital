defmodule Hospital.Staff.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :date, :string
    field :day, :string
    field :from, :string
    field :to, :string

    belongs_to :doctor, Hospital.Staff.Doctor, foreign_key: :doctor_id
    belongs_to :patient, Hospital.Patients.Patient, foreign_key: :patient_id

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:from, :to, :date, :doctor_id, :patient_id])
    |> validate_required([:from, :to, :date, :doctor_id, :patient_id])
  end
end
