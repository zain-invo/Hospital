defmodule Hospital.BillingTest do
  use Hospital.DataCase

  alias Hospital.Billing

  describe "bills" do
    alias Hospital.Billing.Bill

    @valid_attrs %{date_purchased: ~N[2010-04-17 14:00:00], med_name: "some med_name", price_per_unit: 120.5, quantity: 42}
    @update_attrs %{date_purchased: ~N[2011-05-18 15:01:01], med_name: "some updated med_name", price_per_unit: 456.7, quantity: 43}
    @invalid_attrs %{date_purchased: nil, med_name: nil, price_per_unit: nil, quantity: nil}

    def bill_fixture(attrs \\ %{}) do
      {:ok, bill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Billing.create_bill()

      bill
    end

    test "list_bills/0 returns all bills" do
      bill = bill_fixture()
      assert Billing.list_bills() == [bill]
    end

    test "get_bill!/1 returns the bill with given id" do
      bill = bill_fixture()
      assert Billing.get_bill!(bill.id) == bill
    end

    test "create_bill/1 with valid data creates a bill" do
      assert {:ok, %Bill{} = bill} = Billing.create_bill(@valid_attrs)
      assert bill.date_purchased == ~N[2010-04-17 14:00:00]
      assert bill.med_name == "some med_name"
      assert bill.price_per_unit == 120.5
      assert bill.quantity == 42
    end

    test "create_bill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_bill(@invalid_attrs)
    end

    test "update_bill/2 with valid data updates the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{} = bill} = Billing.update_bill(bill, @update_attrs)
      assert bill.date_purchased == ~N[2011-05-18 15:01:01]
      assert bill.med_name == "some updated med_name"
      assert bill.price_per_unit == 456.7
      assert bill.quantity == 43
    end

    test "update_bill/2 with invalid data returns error changeset" do
      bill = bill_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_bill(bill, @invalid_attrs)
      assert bill == Billing.get_bill!(bill.id)
    end

    test "delete_bill/1 deletes the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{}} = Billing.delete_bill(bill)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_bill!(bill.id) end
    end

    test "change_bill/1 returns a bill changeset" do
      bill = bill_fixture()
      assert %Ecto.Changeset{} = Billing.change_bill(bill)
    end
  end

  describe "bills" do
    alias Hospital.Billing.Bill

    @valid_attrs %{date_purchased: ~D[2010-04-17], med_name: "some med_name", price_per_unit: 120.5, quantity: 42}
    @update_attrs %{date_purchased: ~D[2011-05-18], med_name: "some updated med_name", price_per_unit: 456.7, quantity: 43}
    @invalid_attrs %{date_purchased: nil, med_name: nil, price_per_unit: nil, quantity: nil}

    def bill_fixture(attrs \\ %{}) do
      {:ok, bill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Billing.create_bill()

      bill
    end

    test "list_bills/0 returns all bills" do
      bill = bill_fixture()
      assert Billing.list_bills() == [bill]
    end

    test "get_bill!/1 returns the bill with given id" do
      bill = bill_fixture()
      assert Billing.get_bill!(bill.id) == bill
    end

    test "create_bill/1 with valid data creates a bill" do
      assert {:ok, %Bill{} = bill} = Billing.create_bill(@valid_attrs)
      assert bill.date_purchased == ~D[2010-04-17]
      assert bill.med_name == "some med_name"
      assert bill.price_per_unit == 120.5
      assert bill.quantity == 42
    end

    test "create_bill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_bill(@invalid_attrs)
    end

    test "update_bill/2 with valid data updates the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{} = bill} = Billing.update_bill(bill, @update_attrs)
      assert bill.date_purchased == ~D[2011-05-18]
      assert bill.med_name == "some updated med_name"
      assert bill.price_per_unit == 456.7
      assert bill.quantity == 43
    end

    test "update_bill/2 with invalid data returns error changeset" do
      bill = bill_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_bill(bill, @invalid_attrs)
      assert bill == Billing.get_bill!(bill.id)
    end

    test "delete_bill/1 deletes the bill" do
      bill = bill_fixture()
      assert {:ok, %Bill{}} = Billing.delete_bill(bill)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_bill!(bill.id) end
    end

    test "change_bill/1 returns a bill changeset" do
      bill = bill_fixture()
      assert %Ecto.Changeset{} = Billing.change_bill(bill)
    end
  end
end
