defmodule Workbench.ItemsTest do
  use Workbench.DataCase

  alias Workbench.Items

  describe "tools" do
    alias Workbench.Items.Tool

    import Workbench.ItemsFixtures

    @invalid_attrs %{name: nil, description: nil, image_url: nil}

    test "list_tools/0 returns all tools" do
      tool = tool_fixture()
      assert Items.list_tools() == [tool]
    end

    test "get_tool!/1 returns the tool with given id" do
      tool = tool_fixture()
      assert Items.get_tool!(tool.id) == tool
    end

    test "create_tool/1 with valid data creates a tool" do
      valid_attrs = %{name: "some name", description: "some description", image_url: "some image_url"}

      assert {:ok, %Tool{} = tool} = Items.create_tool(valid_attrs)
      assert tool.name == "some name"
      assert tool.description == "some description"
      assert tool.image_url == "some image_url"
    end

    test "create_tool/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_tool(@invalid_attrs)
    end

    test "update_tool/2 with valid data updates the tool" do
      tool = tool_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", image_url: "some updated image_url"}

      assert {:ok, %Tool{} = tool} = Items.update_tool(tool, update_attrs)
      assert tool.name == "some updated name"
      assert tool.description == "some updated description"
      assert tool.image_url == "some updated image_url"
    end

    test "update_tool/2 with invalid data returns error changeset" do
      tool = tool_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_tool(tool, @invalid_attrs)
      assert tool == Items.get_tool!(tool.id)
    end

    test "delete_tool/1 deletes the tool" do
      tool = tool_fixture()
      assert {:ok, %Tool{}} = Items.delete_tool(tool)
      assert_raise Ecto.NoResultsError, fn -> Items.get_tool!(tool.id) end
    end

    test "change_tool/1 returns a tool changeset" do
      tool = tool_fixture()
      assert %Ecto.Changeset{} = Items.change_tool(tool)
    end
  end

  describe "supplies" do
    alias Workbench.Items.Supply

    import Workbench.ItemsFixtures

    @invalid_attrs %{name: nil, description: nil, quantity: nil, restock_link: nil, image_url: nil, price: nil}

    test "list_supplies/0 returns all supplies" do
      supply = supply_fixture()
      assert Items.list_supplies() == [supply]
    end

    test "get_supply!/1 returns the supply with given id" do
      supply = supply_fixture()
      assert Items.get_supply!(supply.id) == supply
    end

    test "create_supply/1 with valid data creates a supply" do
      valid_attrs = %{name: "some name", description: "some description", quantity: 42, restock_link: "some restock_link", image_url: "some image_url", price: "120.5"}

      assert {:ok, %Supply{} = supply} = Items.create_supply(valid_attrs)
      assert supply.name == "some name"
      assert supply.description == "some description"
      assert supply.quantity == 42
      assert supply.restock_link == "some restock_link"
      assert supply.image_url == "some image_url"
      assert supply.price == Decimal.new("120.5")
    end

    test "create_supply/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_supply(@invalid_attrs)
    end

    test "update_supply/2 with valid data updates the supply" do
      supply = supply_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", quantity: 43, restock_link: "some updated restock_link", image_url: "some updated image_url", price: "456.7"}

      assert {:ok, %Supply{} = supply} = Items.update_supply(supply, update_attrs)
      assert supply.name == "some updated name"
      assert supply.description == "some updated description"
      assert supply.quantity == 43
      assert supply.restock_link == "some updated restock_link"
      assert supply.image_url == "some updated image_url"
      assert supply.price == Decimal.new("456.7")
    end

    test "update_supply/2 with invalid data returns error changeset" do
      supply = supply_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_supply(supply, @invalid_attrs)
      assert supply == Items.get_supply!(supply.id)
    end

    test "delete_supply/1 deletes the supply" do
      supply = supply_fixture()
      assert {:ok, %Supply{}} = Items.delete_supply(supply)
      assert_raise Ecto.NoResultsError, fn -> Items.get_supply!(supply.id) end
    end

    test "change_supply/1 returns a supply changeset" do
      supply = supply_fixture()
      assert %Ecto.Changeset{} = Items.change_supply(supply)
    end
  end
end
