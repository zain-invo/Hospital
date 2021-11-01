defmodule Hospital.Repo.Migrations.CreateTimings do
  use Ecto.Migration

  def change do
    create table(:timings) do
      add :days_in_week, :string
      add :times, :naive_datetime

      timestamps()
    end

  end
end
