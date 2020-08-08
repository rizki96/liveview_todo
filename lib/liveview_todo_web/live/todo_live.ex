defmodule LiveviewTodoWeb.TodoLive do
    use LiveviewTodoWeb, :live_view

    alias LiveviewTodo.Tasks
    alias LiveviewTodoWeb.Todos.AddTodoFormComponent
    alias LiveviewTodoWeb.Todos.TodoListComponent

    require Logger

    @impl true
    def mount(_params, _session, socket) do
        {:ok, todos} = Tasks.list_todos()
        todos = Enum.map(todos, fn {_, todo} -> todo end)
        socket = assign(socket, todos: todos)

        {:ok, assign(socket, temporary_assigns: [todos: []])}
    end

    @impl true
    def handle_event("add_todo", %{"todo" => todo} = _params, socket) do
        Logger.log(:debug, "#{inspect todo}")
        new_todo = Tasks.create_todo(todo)

        {:noreply, assign(socket, :todos, [new_todo])}
    end

    @impl true
    def handle_event("update_todo:" <> todo_id, params, socket) do
        Logger.log(:debug, "#{inspect params}")
        old_todo = Tasks.get_todo!(String.to_integer(todo_id))
        socket =
        if old_todo do
            updated_todo = Tasks.update_todo(old_todo,
                     (if Map.has_key?(params, "value") and params["value"] == "true",
                         do: %{completed: true, id: old_todo.id, text: old_todo.text},
                         else: %{completed: false, id: old_todo.id, text: old_todo.text}))
            assign(socket, :todos, [updated_todo])
        else
            socket
        end

        {:noreply, socket}
    end
end
