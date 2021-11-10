defmodule HospitalWeb.BillController do
  use HospitalWeb, :controller

  alias Hospital.Billing
  alias Hospital.Billing.Bill

  def index(conn, _params) do
    bills = Billing.list_bills()
    render(conn, "index.html", bills: bills)
  end

  def new(conn, _params) do
    changeset = Billing.change_bill(%Bill{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bill" => bill_params}) do
    case Billing.create_bill(bill_params) do
      {:ok, bill} ->
        conn
        |> put_flash(:info, "Bill created successfully.")
        |> redirect(to: Routes.bill_path(conn, :show, bill))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bill = Billing.get_bill!(id)
    render(conn, "show.html", bill: bill)
  end

  def edit(conn, %{"id" => id}) do
    bill = Billing.get_bill!(id)
    changeset = Billing.change_bill(bill)
    render(conn, "edit.html", bill: bill, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bill" => bill_params}) do
    bill = Billing.get_bill!(id)

    case Billing.update_bill(bill, bill_params) do
      {:ok, bill} ->
        conn
        |> put_flash(:info, "Bill updated successfully.")
        |> redirect(to: Routes.bill_path(conn, :show, bill))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bill: bill, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bill = Billing.get_bill!(id)
    {:ok, _bill} = Billing.delete_bill(bill)

    conn
    |> put_flash(:info, "Bill deleted successfully.")
    |> redirect(to: Routes.bill_path(conn, :index))
  end
end
