defmodule Hospital.Staff.Appointment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appointments" do
    field :day, :string
    field :from, :naive_datetime
    field :to, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(appointment, attrs) do
    appointment
    |> cast(attrs, [:from, :to, :day])
    |> validate_required([:from, :to, :day])
  end
end
