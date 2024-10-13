defmodule WorkbenchWeb.SupplyLiveTest do
  use WorkbenchWeb.ConnCase

  import Phoenix.LiveViewTest
  import Workbench.ItemsFixtures

  @create_attrs %{name: "some name", description: "some description", quantity: 42, restock_link: "some restock_link", image_url: "some image_url", price: "120.5"}
  @update_attrs %{name: "some updated name", description: "some updated description", quantity: 43, restock_link: "some updated restock_link", image_url: "some updated image_url", price: "456.7"}
  @invalid_attrs %{name: nil, description: nil, quantity: nil, restock_link: nil, image_url: nil, price: nil}

  defp create_supply(_) do
    supply = supply_fixture()
    %{supply: supply}
  end

  describe "Index" do
    setup [:create_supply]

    test "lists all supplies", %{conn: conn, supply: supply} do
      {:ok, _index_live, html} = live(conn, ~p"/supplies")

      assert html =~ "Listing Supplies"
      assert html =~ supply.name
    end

    test "saves new supply", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/supplies")

      assert index_live |> element("a", "New Supply") |> render_click() =~
               "New Supply"

      assert_patch(index_live, ~p"/supplies/new")

      assert index_live
             |> form("#supply-form", supply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#supply-form", supply: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/supplies")

      html = render(index_live)
      assert html =~ "Supply created successfully"
      assert html =~ "some name"
    end

    test "updates supply in listing", %{conn: conn, supply: supply} do
      {:ok, index_live, _html} = live(conn, ~p"/supplies")

      assert index_live |> element("#supplies-#{supply.id} a", "Edit") |> render_click() =~
               "Edit Supply"

      assert_patch(index_live, ~p"/supplies/#{supply}/edit")

      assert index_live
             |> form("#supply-form", supply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#supply-form", supply: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/supplies")

      html = render(index_live)
      assert html =~ "Supply updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes supply in listing", %{conn: conn, supply: supply} do
      {:ok, index_live, _html} = live(conn, ~p"/supplies")

      assert index_live |> element("#supplies-#{supply.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#supplies-#{supply.id}")
    end
  end

  describe "Show" do
    setup [:create_supply]

    test "displays supply", %{conn: conn, supply: supply} do
      {:ok, _show_live, html} = live(conn, ~p"/supplies/#{supply}")

      assert html =~ "Show Supply"
      assert html =~ supply.name
    end

    test "updates supply within modal", %{conn: conn, supply: supply} do
      {:ok, show_live, _html} = live(conn, ~p"/supplies/#{supply}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Supply"

      assert_patch(show_live, ~p"/supplies/#{supply}/show/edit")

      assert show_live
             |> form("#supply-form", supply: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#supply-form", supply: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/supplies/#{supply}")

      html = render(show_live)
      assert html =~ "Supply updated successfully"
      assert html =~ "some updated name"
    end
  end
end
