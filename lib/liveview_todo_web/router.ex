defmodule LiveviewTodoWeb.Router do
  use LiveviewTodoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveviewTodoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveviewTodoWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/todo", TodoLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveviewTodoWeb do
  #   pipe_through :api
  # end
end
