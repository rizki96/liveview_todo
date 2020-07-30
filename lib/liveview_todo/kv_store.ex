defmodule LiveviewTodo.KvStore do
    
    require Logger

    def child_spec(_) do
      Supervisor.Spec.worker(CubDB, [Application.get_env(:liveview_todo, __MODULE__)[:data_dir], [name: __MODULE__]])
      #%{id: __MODULE__, start: {CubDB, :start_link, [Application.get_env(:liveview_todo, __MODULE__)[:data_dir], [name: __MODULE__]]}}
    end
  
    def init() do
      Logger.log(:debug, "#{__MODULE__}:init")
      CubDB.set_auto_compact(__MODULE__, true)
      CubDB.set_auto_file_sync(__MODULE__, true)
      :ok
    end
  
  end