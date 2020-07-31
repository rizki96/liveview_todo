defmodule LiveviewTodoWeb.TodoLive do
    use LiveviewTodoWeb, :live_view
  
    @impl true
    def mount(_params, _session, socket) do
        
        {:ok, assign(socket, todos: %{})}
    end

end
