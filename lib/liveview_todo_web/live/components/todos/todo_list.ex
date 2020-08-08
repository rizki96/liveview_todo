defmodule LiveviewTodoWeb.Todos.TodoListComponent do
  use Phoenix.LiveComponent

  alias LiveviewTodoWeb.Todos.TodoListItemComponent
  require Logger

  def render(assigns) do
    ~L"""
    <ul phx-update="append">
        <%= for todo <- @todos do %>
            <%= live_component @socket, TodoListItemComponent, id: todo.id, todo: todo %>
        <% end %>
    </ul>
    """
  end

  def mount(socket) do
    Logger.log(:debug, "#{inspect socket.assigns}")

    {:ok, socket}
  end

end