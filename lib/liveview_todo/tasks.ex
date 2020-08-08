defmodule LiveviewTodo.Tasks do
  @moduledoc false

  alias LiveviewTodo.KvStore

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

  def list_todos do
    CubDB.select(LiveviewTodo.KvStore,
      #reverse: true,
      min_key_inclusive: false,
      min_key: {:todos, 0},
      max_key: {:todos, nil}
    )
  end

  def get_todo!(id), do: KvStore.get_data(:todos, id)

  def create_todo(attrs \\ %{}) do
    new_todo = change_todo(%Todo{}, attrs)
    KvStore.new_data(:todos, Todo.new(new_todo.text))
  end

  def update_todo(%Todo{} = todo, attrs) do
    updated_todo = change_todo(todo, attrs)
    KvStore.update_data(:todos, todo.id, updated_todo)
  end

  def delete_todo(%_Todo{} = todo) do
    KvStore.delete_data(:todos, todo.id)
  end

  def change_todo(%Todo{} = todo, attrs \\ %{}) do
    KvStore.struct_from_map(attrs, as: todo)
  end
end
