defmodule LiveviewTodo.Tasks do
  @moduledoc """
  The Tasks context.
  """

  defmodule Todo do
    defstruct [
        id: nil,
        text: nil,
        completed: false
    ]

    def new do
      %__MODULE__{}
    end
  end

  alias LiveviewTodo.KvStore

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos do
    CubDB.select(__MODULE__,
      min_key_inclusive: false,
      max_key: {:todos, _}},
    )
  end

  @doc """
  Gets a single todo.

  Raises if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

  """
  def get_todo!(_id), do: raise "TODO"

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, ...}

  """
  def create_todo(_attrs \\ %{}) do
    raise "TODO"
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, ...}

  """
  def update_todo(%Todo{} = _todo, _attrs) do
    raise "TODO"
  end

  @doc """
  Deletes a Todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, ...}

  """
  def delete_todo(%_Todo{} = _todo) do
    raise "TODO"
  end

  @doc """
  Returns a data structure for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Todo{...}

  """
  def change_todo(%Todo{} = _todo, _attrs \\ %{}) do
    raise "TODO"
  end
end
