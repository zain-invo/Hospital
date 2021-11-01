defmodule Hospital.Staff.Timing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "timings" do
    field :days_in_week, :string
    field :times, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(timing, attrs) do
    timing
    |> cast(attrs, [:days_in_week, :times])
    |> validate_required([:days_in_week, :times])
  end
end
