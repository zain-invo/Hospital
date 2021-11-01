defmodule Hospital.Repo.Migrations.CreatePatients do
  use Ecto.Migration

  def change do
    create table(:patients) do
      add :name, :string
      add :disease, :string
      add :gender, :string
      add :age, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:patients, [:user_id])
  end
end
