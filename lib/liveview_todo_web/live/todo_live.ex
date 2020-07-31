defmodule LiveviewTodoWeb.TodoLive do
    use LiveviewTodoWeb, :live_view
  
    alias LiveviewTodoWeb.Todos.AddTodoFormComponent
    require Logger

    @impl true
    def mount(_params, _session, socket) do
        
        {:ok, assign(socket, todos: %{})}
    end

    @impl true
    def handle_event("add_todo", %{"todo" => todo} = _params, socket) do
        Logger.log(:debug, "#{inspect todo}")

        {:noreply, socket}
    end

end
