defmodule LiveviewTodo.TasksTest do
  use LiveviewTodo.DataCase

  alias LiveviewTodo.Tasks

  describe "todos" do
    alias LiveviewTodo.Tasks.Todo

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def todo_fixture(attrs \\ %{}) do
      {:ok, todo} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_todo()

      todo
    end

    test "list_todos/0 returns all todos" do
      todo = todo_fixture()
      assert Tasks.list_todos() == [todo]
    end

    test "get_todo!/1 returns the todo with given id" do
      todo = todo_fixture()
      assert Tasks.get_todo!(todo.id) == todo
    end

    test "create_todo/1 with valid data creates a todo" do
      assert {:ok, %Todo{} = todo} = Tasks.create_todo(@valid_attrs)
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{} = todo} = Tasks.update_todo(todo, @update_attrs)
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todo = todo_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_todo(todo, @invalid_attrs)
      assert todo == Tasks.get_todo!(todo.id)
    end

    test "delete_todo/1 deletes the todo" do
      todo = todo_fixture()
      assert {:ok, %Todo{}} = Tasks.delete_todo(todo)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_todo!(todo.id) end
    end

    test "change_todo/1 returns a todo changeset" do
      todo = todo_fixture()
      assert %Ecto.Changeset{} = Tasks.change_todo(todo)
    end
  end
end
