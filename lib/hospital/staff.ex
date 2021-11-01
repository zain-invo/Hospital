defmodule Hospital.Staff do
  @moduledoc """
  The Staff context.
  """

  import Ecto.Query, warn: false
  alias Hospital.Repo

  alias Hospital.Staff.Doctor

  @doc """
  Returns the list of doctors.

  ## Examples

      iex> list_doctors()
      [%Doctor{}, ...]

  """
  def list_doctors do
    Repo.all(Doctor)
  end

  @doc """
  Gets a single doctor.

  Raises `Ecto.NoResultsError` if the Doctor does not exist.

  ## Examples

      iex> get_doctor!(123)
      %Doctor{}

      iex> get_doctor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_doctor!(id), do: Repo.get!(Doctor, id)

  def get_doctor_by_uid!(user_id) do
    query =
      from d in "doctors",
        where: d.user_id == ^user_id,
        select: %Doctor{id: d.id, name: d.name, speciality: d.speciality, active: d.active}

    Repo.one(query)
  end

  @doc """
  Creates a doctor.

  ## Examples

      iex> create_doctor(%{field: value})
      {:ok, %Doctor{}}

      iex> create_doctor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_doctor(attrs \\ %{}) do
    %Doctor{}
    |> Doctor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a doctor.

  ## Examples

      iex> update_doctor(doctor, %{field: new_value})
      {:ok, %Doctor{}}

      iex> update_doctor(doctor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_doctor(%Doctor{} = doctor, attrs) do
    doctor
    |> Doctor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a doctor.

  ## Examples

      iex> delete_doctor(doctor)
      {:ok, %Doctor{}}

      iex> delete_doctor(doctor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_doctor(%Doctor{} = doctor) do
    Repo.delete(doctor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking doctor changes.

  ## Examples

      iex> change_doctor(doctor)
      %Ecto.Changeset{data: %Doctor{}}

  """
  def change_doctor(%Doctor{} = doctor, attrs \\ %{}) do
    Doctor.changeset(doctor, attrs)
  end

  alias Hospital.Staff.Timing

  @doc """
  Returns the list of timings.

  ## Examples

      iex> list_timings()
      [%Timing{}, ...]

  """
  def list_timings do
    Repo.all(Timing)
  end

  @doc """
  Gets a single timing.

  Raises `Ecto.NoResultsError` if the Timing does not exist.

  ## Examples

      iex> get_timing!(123)
      %Timing{}

      iex> get_timing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timing!(id), do: Repo.get!(Timing, id)

  @doc """
  Creates a timing.

  ## Examples

      iex> create_timing(%{field: value})
      {:ok, %Timing{}}

      iex> create_timing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timing(attrs \\ %{}) do
    %Timing{}
    |> Timing.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timing.

  ## Examples

      iex> update_timing(timing, %{field: new_value})
      {:ok, %Timing{}}

      iex> update_timing(timing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timing(%Timing{} = timing, attrs) do
    timing
    |> Timing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a timing.

  ## Examples

      iex> delete_timing(timing)
      {:ok, %Timing{}}

      iex> delete_timing(timing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timing(%Timing{} = timing) do
    Repo.delete(timing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timing changes.

  ## Examples

      iex> change_timing(timing)
      %Ecto.Changeset{data: %Timing{}}

  """
  def change_timing(%Timing{} = timing, attrs \\ %{}) do
    Timing.changeset(timing, attrs)
  end
end