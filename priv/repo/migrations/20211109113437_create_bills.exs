defmodule Hospital.Repo.Migrations.CreateBills do
  use Ecto.Migration

  def change do
    create table(:bills) do
      add :med_name, :string
      add :price_per_unit, :float
      add :quantity, :integer
      add :date_purchased, :date
      add :patient_id, references(:patients, on_delete: :nothing)

      timestamps()
    end

    create index(:bills, [:patient_id])
  end
end
