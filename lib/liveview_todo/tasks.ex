defmodule LiveviewTodo.Tasks do
  @moduledoc """
  The Tasks context.
  """

  alias LiveviewTodo.KvStore

  #require Logger

  defmodule Todo do
    @derive {Jason.Encoder, only: [:id, :text, :completed]}
    defstruct [
        id: nil,
        text: nil,
        completed: false
    ]

    def new(text) do
      meta = KvStore.get_meta(:todos)
      %__MODULE__{id: meta.last_registered_id + 1, text: text, completed: false}
    end
  end

  @doc """
  Returns the list of todos.

  ## Examples

      iex> list_todos()
      [%Todo{}, ...]

  """
  def list_todos do
    CubDB.select(LiveviewTodo.KvStore,
      #reverse: true,
      min_key_inclusive: false,
      min_key: {:todos, 0},
      max_key: {:todos, nil}
    )
  end

  @doc """
  Gets a single todo.

  Raises if the Todo does not exist.

  ## Examples

      iex> get_todo!(123)
      %Todo{}

  """
  def get_todo!(id), do: KvStore.get_data(:todos, id)

  @doc """
  Creates a todo.

  ## Examples

      iex> create_todo(%{field: value})
      {:ok, %Todo{}}

      iex> create_todo(%{field: bad_value})
      {:error, ...}

  """
  def create_todo(attrs \\ %{}) do
    new_todo = change_todo(%Todo{}, attrs)
    KvStore.new_data(:todos, Todo.new(new_todo.text))
  end

  @doc """
  Updates a todo.

  ## Examples

      iex> update_todo(todo, %{field: new_value})
      {:ok, %Todo{}}

      iex> update_todo(todo, %{field: bad_value})
      {:error, ...}

  """
  def update_todo(%Todo{} = todo, attrs) do
    updated_todo = change_todo(todo, attrs)
    KvStore.update_data(:todos, todo.id, updated_todo)
  end

  @doc """
  Deletes a Todo.

  ## Examples

      iex> delete_todo(todo)
      {:ok, %Todo{}}

      iex> delete_todo(todo)
      {:error, ...}

  """
  def delete_todo(%_Todo{} = todo) do
    KvStore.delete_data(:todos, todo.id)
  end

  @doc """
  Returns a data structure for tracking todo changes.

  ## Examples

      iex> change_todo(todo)
      %Todo{...}

  """
  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    KvStore.struct_from_map(attrs, as: todo)
  end
end
