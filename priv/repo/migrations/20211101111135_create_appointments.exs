defmodule Hospital.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :from, :string
      add :to, :string
      add :date, :string
      add :day, :string
      add :patient_id, references(:patients, on_delete: :nothing)
      add :doctor_id, references(:doctors, on_delete: :nothing)

      timestamps()
    end

    create index(:appointments, [:patient_id])
    create index(:appointments, [:doctor_id])
  end
end
