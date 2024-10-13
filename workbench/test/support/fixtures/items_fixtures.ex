defmodule Workbench.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workbench.Items` context.
  """

  @doc """
  Generate a tool.
  """
  def tool_fixture(attrs \\ %{}) do
    {:ok, tool} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name"
      })
      |> Workbench.Items.create_tool()

    tool
  end

  @doc """
  Generate a supply.
  """
  def supply_fixture(attrs \\ %{}) do
    {:ok, supply} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image_url: "some image_url",
        name: "some name",
        price: "120.5",
        quantity: 42,
        restock_link: "some restock_link"
      })
      |> Workbench.Items.create_supply()

    supply
  end
end
