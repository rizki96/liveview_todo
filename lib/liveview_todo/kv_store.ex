defmodule LiveviewTodo.KvStore do
    
  require Logger

  defmodule MetaRecord do
    defstruct [
      last_registered_id: 0
    ]

    def new do
      %__MODULE__{}
    end
  end

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

  def new_data(record, data) do
    meta = CubDB.get_meta(record)
    CubDB.put(__MODULE__, {record, meta.last_registered_id + 1}, data)
    CubDB.update_meta(record, meta.last_registered_id + 1)
  end

  def update_data(record, id, data) do
    CubDB.put(__MODULE__, {record, id}, data)
    {record, id}
  end

  def delete_data(record, id) do
    CubDB.delete(__MODULE__, {record, id})
    {record, id}
  end

  def get_data(record, id) do
    CubDB.get(__MODULE__, {record, id})
  end

  defp get_meta(record) do
    CubDB.get(__MODULE__, {:meta_record, record}, MetaRecord.new)
  end

  defp update_meta(record, last_registered_id) do
    CubDB.put(__MODULE__, {:meta_record, record}, %MetaRecord{last_registered_id: last_registered_id})
    {record, last_registered_id}
  end
end