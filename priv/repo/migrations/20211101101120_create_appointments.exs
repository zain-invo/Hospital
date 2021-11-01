defmodule Hospital.Repo.Migrations.CreateAppointments do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :from, :naive_datetime
      add :to, :naive_datetimemix phx.gen.cogit mix phx.gen.contextntext
      add :day, :string
      add :pat_id, references(:users)
      add :doc_id, references(:doctors)

      timestamps()
    end

  end
end
