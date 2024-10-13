defmodule Workbench.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias Workbench.Repo

  alias Workbench.Items.Tool

  @doc """
  Returns the list of tools.

  ## Examples

      iex> list_tools()
      [%Tool{}, ...]

  """
  def list_tools do
    Repo.all(Tool)
  end

  @doc """
  Gets a single tool.

  Raises `Ecto.NoResultsError` if the Tool does not exist.

  ## Examples

      iex> get_tool!(123)
      %Tool{}

      iex> get_tool!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tool!(id), do: Repo.get!(Tool, id)

  @doc """
  Creates a tool.

  ## Examples

      iex> create_tool(%{field: value})
      {:ok, %Tool{}}

      iex> create_tool(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tool(attrs \\ %{}) do
    %Tool{}
    |> Tool.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tool.

  ## Examples

      iex> update_tool(tool, %{field: new_value})
      {:ok, %Tool{}}

      iex> update_tool(tool, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tool(%Tool{} = tool, attrs) do
    tool
    |> Tool.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tool.

  ## Examples

      iex> delete_tool(tool)
      {:ok, %Tool{}}

      iex> delete_tool(tool)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tool(%Tool{} = tool) do
    Repo.delete(tool)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tool changes.

  ## Examples

      iex> change_tool(tool)
      %Ecto.Changeset{data: %Tool{}}

  """
  def change_tool(%Tool{} = tool, attrs \\ %{}) do
    Tool.changeset(tool, attrs)
  end

  alias Workbench.Items.Supply

  @doc """
  Returns the list of supplies.

  ## Examples

      iex> list_supplies()
      [%Supply{}, ...]

  """
  def list_supplies do
    Repo.all(Supply)
  end

  @doc """
  Gets a single supply.

  Raises `Ecto.NoResultsError` if the Supply does not exist.

  ## Examples

      iex> get_supply!(123)
      %Supply{}

      iex> get_supply!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supply!(id), do: Repo.get!(Supply, id)

  @doc """
  Creates a supply.

  ## Examples

      iex> create_supply(%{field: value})
      {:ok, %Supply{}}

      iex> create_supply(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supply(attrs \\ %{}) do
    %Supply{}
    |> Supply.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supply.

  ## Examples

      iex> update_supply(supply, %{field: new_value})
      {:ok, %Supply{}}

      iex> update_supply(supply, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supply(%Supply{} = supply, attrs) do
    supply
    |> Supply.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supply.

  ## Examples

      iex> delete_supply(supply)
      {:ok, %Supply{}}

      iex> delete_supply(supply)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supply(%Supply{} = supply) do
    Repo.delete(supply)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supply changes.

  ## Examples

      iex> change_supply(supply)
      %Ecto.Changeset{data: %Supply{}}

  """
  def change_supply(%Supply{} = supply, attrs \\ %{}) do
    Supply.changeset(supply, attrs)
  end
end
