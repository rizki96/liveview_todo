defmodule LiveviewTodoWeb.TodoLive do
    use LiveviewTodoWeb, :live_view

    alias LiveviewTodo.Tasks
    alias LiveviewTodoWeb.Todos.AddTodoFormComponent
    require Logger

    @impl true
    def mount(_params, _session, socket) do
        todos = Tasks.list_todos()
        {:ok, assign(socket, todos: todos)}
    end

    @impl true
    def handle_event("add_todo", %{"todo" => todo} = _params, socket) do
        Logger.log(:debug, "#{inspect todo}")

        {:noreply, socket}
    end

end
