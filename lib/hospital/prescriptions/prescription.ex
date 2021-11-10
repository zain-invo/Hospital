defmodule Hospital.Prescriptions.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prescriptions" do
    field :dose, :string
    field :med_name, :string
    field :times_in_day, :string
    belongs_to :patients, Hospital.Patients.Patient, foreign_key: :patient_id
    belongs_to :doctors, Hospital.Staff.Doctor, foreign_key: :doctor_id
    # field :patient_id, :integer
    # field :doctor_id, :integer


    timestamps()
  end

  @doc false
  def changeset(prescription, attrs) do
    prescription
    |> cast(attrs, [:med_name, :dose, :times_in_day, :patient_id, :doctor_id])
    |> validate_required([:med_name, :dose, :times_in_day, :patient_id, :doctor_id])
    |> foreign_key_constraint(:doctor_id)
    |> foreign_key_constraint(:patient_id)
  end
end
