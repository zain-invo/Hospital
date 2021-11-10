defmodule Hospital.Prescriptions do
  @moduledoc """
  The Prescriptions context.
  """

  import Ecto.Query, warn: false
  alias Hospital.Repo

  alias Hospital.Prescriptions.Prescription

  @doc """
  Returns the list of prescriptions.

  ## Examples

      iex> list_prescriptions()
      [%Prescription{}, ...]

  """
  def list_prescriptions do
    Repo.all(Prescription)
  end

  def patient_prescriptions(patient_id) do

    if Repo.all(from p in Prescription, where: p.patient_id==^patient_id) do
      Repo.all(from p in Prescription, where: p.patient_id==^patient_id)
    else
      %Prescription{}
    end

  end



  @doc """
  Gets a single prescription.

  Raises `Ecto.NoResultsError` if the Prescription does not exist.

  ## Examples

      iex> get_prescription!(123)
      %Prescription{}

      iex> get_prescription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prescription!(id), do: Repo.get!(Prescription, id)

  @doc """
  Creates a prescription.

  ## Examples

      iex> create_prescription(%{field: value})
      {:ok, %Prescription{}}

      iex> create_prescription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prescription(attrs \\ %{}) do
    result = %Prescription{}
    |>Prescription.changeset(attrs)
    |> Repo.insert()

    IO.inspect(result)
  end

  @doc """
  Updates a prescription.

  ## Examples

      iex> update_prescription(prescription, %{field: new_value})
      {:ok, %Prescription{}}

      iex> update_prescription(prescription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prescription(%Prescription{} = prescription, attrs) do
    prescription
    |> Prescription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prescription.

  ## Examples

      iex> delete_prescription(prescription)
      {:ok, %Prescription{}}

      iex> delete_prescription(prescription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prescription(%Prescription{} = prescription) do
    Repo.delete(prescription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prescription changes.

  ## Examples

      iex> change_prescription(prescription)
      %Ecto.Changeset{data: %Prescription{}}

  """
  def change_prescription(%Prescription{} = prescription, attrs \\ %{}) do
    Prescription.changeset(prescription, attrs)
  end
end
