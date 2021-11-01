defmodule Hospital.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end

  end
end
