defmodule Hospital.Repo.Migrations.CreatePrescriptions do
  use Ecto.Migration

  def change do
    create table(:prescriptions) do
      add :med_name, :string
      add :dose, :string
      add :times_in_day, :string
      add :patient_id, references(:patients, on_delete: :nothing)
      add :doctor_id, references(:doctors, on_delete: :nothing)

      timestamps()
    end

    create index(:prescriptions, [:patient_id])
    create index(:prescriptions, [:doctor_id])
  end
end
