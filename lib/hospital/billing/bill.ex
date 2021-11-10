defmodule Hospital.Billing.Bill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bills" do
    field :date_purchased, :date
    field :med_name, :string
    field :price_per_unit, :float
    field :quantity, :integer
    field :patient_id, :integer

    timestamps()
  end

  @doc false
  def changeset(bill, attrs) do
    bill
    |> cast(attrs, [:med_name, :price_per_unit, :quantity, :date_purchased, :patient_id])
    |> validate_required([:med_name, :price_per_unit, :quantity, :date_purchased, :patient_id])
    |> foreign_key_constraint(:patient_id)
  end
end
