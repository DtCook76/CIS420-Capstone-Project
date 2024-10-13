defmodule Workbench.GarageFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Workbench.Garage` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Workbench.Garage.create_location()

    location
  end

  @doc """
  Generate a container.
  """
  def container_fixture(attrs \\ %{}) do
    {:ok, container} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        type: "some type"
      })
      |> Workbench.Garage.create_container()

    container
  end
end
