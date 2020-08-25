defmodule LiveviewTodoWeb.Todos.TodoListItemComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  alias LiveviewTodoWeb.Router.Helpers, as: Routes
  alias LiveviewTodoWeb.TodoLive

  require Logger

  def render(assigns) do
    ~L"""
    <li id="list-item-<%= @todo.id %>" phx-update="replace">
        <label class='<%= if @todo.completed == true, do: "complete", else: "" %>'>
            <%= checkbox(:todo, :completed, phx_click: "update_todo:#{@todo.id}", phx_value: Jason.encode!(@todo), id: "chkbox-#{@todo.id}", checked: @todo.completed) %>
            <%= @todo.text %>
        </label>
        <%= live_patch("X", to: Routes.live_path(@socket, TodoLive, [id: @todo.id, action: :delete]), replace: false) %>
    </li>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

end
