defmodule Hospital.Repo.Migrations.UpdateUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password, :string
      add :type, :string

    end
  end
end
