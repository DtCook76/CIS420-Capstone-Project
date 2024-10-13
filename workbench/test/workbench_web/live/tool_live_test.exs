defmodule WorkbenchWeb.ToolLiveTest do
  use WorkbenchWeb.ConnCase

  import Phoenix.LiveViewTest
  import Workbench.ItemsFixtures

  @create_attrs %{name: "some name", description: "some description", image_url: "some image_url"}
  @update_attrs %{name: "some updated name", description: "some updated description", image_url: "some updated image_url"}
  @invalid_attrs %{name: nil, description: nil, image_url: nil}

  defp create_tool(_) do
    tool = tool_fixture()
    %{tool: tool}
  end

  describe "Index" do
    setup [:create_tool]

    test "lists all tools", %{conn: conn, tool: tool} do
      {:ok, _index_live, html} = live(conn, ~p"/tools")

      assert html =~ "Listing Tools"
      assert html =~ tool.name
    end

    test "saves new tool", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tools")

      assert index_live |> element("a", "New Tool") |> render_click() =~
               "New Tool"

      assert_patch(index_live, ~p"/tools/new")

      assert index_live
             |> form("#tool-form", tool: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tool-form", tool: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tools")

      html = render(index_live)
      assert html =~ "Tool created successfully"
      assert html =~ "some name"
    end

    test "updates tool in listing", %{conn: conn, tool: tool} do
      {:ok, index_live, _html} = live(conn, ~p"/tools")

      assert index_live |> element("#tools-#{tool.id} a", "Edit") |> render_click() =~
               "Edit Tool"

      assert_patch(index_live, ~p"/tools/#{tool}/edit")

      assert index_live
             |> form("#tool-form", tool: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#tool-form", tool: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tools")

      html = render(index_live)
      assert html =~ "Tool updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes tool in listing", %{conn: conn, tool: tool} do
      {:ok, index_live, _html} = live(conn, ~p"/tools")

      assert index_live |> element("#tools-#{tool.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tools-#{tool.id}")
    end
  end

  describe "Show" do
    setup [:create_tool]

    test "displays tool", %{conn: conn, tool: tool} do
      {:ok, _show_live, html} = live(conn, ~p"/tools/#{tool}")

      assert html =~ "Show Tool"
      assert html =~ tool.name
    end

    test "updates tool within modal", %{conn: conn, tool: tool} do
      {:ok, show_live, _html} = live(conn, ~p"/tools/#{tool}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Tool"

      assert_patch(show_live, ~p"/tools/#{tool}/show/edit")

      assert show_live
             |> form("#tool-form", tool: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#tool-form", tool: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tools/#{tool}")

      html = render(show_live)
      assert html =~ "Tool updated successfully"
      assert html =~ "some updated name"
    end
  end
end
