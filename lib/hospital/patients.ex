defmodule Hospital.Patients do
  @moduledoc """
  The Patients context.
  """

  import Ecto.Query, warn: false
  alias Hospital.Repo
  alias Hospital.Staff.Appointment

  alias Hospital.Patients.Patient

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get_patient!(456)
      ** (Ecto.NoResultsError)

  """

  def is_patient_free(patient_id, date, from, to) when is_nil(patient_id) == false do
    query =
      from a in Appointment,
        join: d in Patient,
        on: a.patient_id == ^patient_id,
        where: a.date == ^date

    query2 = from q in query, where: q.from == ^from
    query3 = from q in query2, where: q.to == ^to

    if is_nil(Repo.one(query3)), do: true, else: false
  end

  def get_patient!(id), do: Repo.get!(Patient, id)

  def get_patient_by_uid!(user_id) do
    query =
      from p in "patients",
        where: p.user_id == ^user_id,
        select: %Patient{id: p.id}

    Repo.one(query)
  end

  def get_patient_name(id) do
    Repo.one(from p in "patients", where: p.id == ^id,
    select: p.name)
  end

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs \\ %{}) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples

      iex> change_patient(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change_patient(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end
end
