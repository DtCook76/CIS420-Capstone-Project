defmodule Workbench.GarageTest do
  use Workbench.DataCase

  alias Workbench.Garage

  describe "locations" do
    alias Workbench.Garage.Location

    import Workbench.GarageFixtures

    @invalid_attrs %{name: nil, description: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Garage.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Garage.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{name: "some name", description: "some description"}

      assert {:ok, %Location{} = location} = Garage.create_location(valid_attrs)
      assert location.name == "some name"
      assert location.description == "some description"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Garage.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description"}

      assert {:ok, %Location{} = location} = Garage.update_location(location, update_attrs)
      assert location.name == "some updated name"
      assert location.description == "some updated description"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Garage.update_location(location, @invalid_attrs)
      assert location == Garage.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Garage.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Garage.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Garage.change_location(location)
    end
  end

  describe "containers" do
    alias Workbench.Garage.Container

    import Workbench.GarageFixtures

    @invalid_attrs %{name: nil, type: nil, description: nil}

    test "list_containers/0 returns all containers" do
      container = container_fixture()
      assert Garage.list_containers() == [container]
    end

    test "get_container!/1 returns the container with given id" do
      container = container_fixture()
      assert Garage.get_container!(container.id) == container
    end

    test "create_container/1 with valid data creates a container" do
      valid_attrs = %{name: "some name", type: "some type", description: "some description"}

      assert {:ok, %Container{} = container} = Garage.create_container(valid_attrs)
      assert container.name == "some name"
      assert container.type == "some type"
      assert container.description == "some description"
    end

    test "create_container/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Garage.create_container(@invalid_attrs)
    end

    test "update_container/2 with valid data updates the container" do
      container = container_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type", description: "some updated description"}

      assert {:ok, %Container{} = container} = Garage.update_container(container, update_attrs)
      assert container.name == "some updated name"
      assert container.type == "some updated type"
      assert container.description == "some updated description"
    end

    test "update_container/2 with invalid data returns error changeset" do
      container = container_fixture()
      assert {:error, %Ecto.Changeset{}} = Garage.update_container(container, @invalid_attrs)
      assert container == Garage.get_container!(container.id)
    end

    test "delete_container/1 deletes the container" do
      container = container_fixture()
      assert {:ok, %Container{}} = Garage.delete_container(container)
      assert_raise Ecto.NoResultsError, fn -> Garage.get_container!(container.id) end
    end

    test "change_container/1 returns a container changeset" do
      container = container_fixture()
      assert %Ecto.Changeset{} = Garage.change_container(container)
    end
  end
end
