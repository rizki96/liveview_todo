defmodule LiveviewTodoWeb.Todos.TodoListItemComponent do
  use Phoenix.LiveComponent
  use Phoenix.HTML

  require Logger

  def render(assigns) do
    ~L"""
    <li id="list-item-<%= @todo.id %>" phx-update="replace">
        <label class='<%= if @todo.completed == true, do: "complete", else: "" %>'>
            <%= checkbox(:todo, :completed, phx_click: "update_todo:#{@todo.id}", phx_value: Jason.encode!(@todo), id: "chkbox-#{@todo.id}", checked: @todo.completed) %>
            <%= @todo.text %>
        </label>
    </li>
    """
  end

  def mount(socket) do
    {:ok, socket}
  end

end