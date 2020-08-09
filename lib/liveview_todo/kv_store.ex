defmodule LiveviewTodo.KvStore do
  @moduledoc false

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
    # NOTE: only for reference, below is how we trigger elixir actor as a supervisor not a worker
    #%{id: __MODULE__, start: {CubDB, :start_link, [Application.get_env(:liveview_todo, __MODULE__)[:data_dir], [name: __MODULE__]]}}
  end

  def init() do
    Logger.log(:debug, "#{__MODULE__}:init")
    CubDB.set_auto_compact(__MODULE__, true)
    CubDB.set_auto_file_sync(__MODULE__, true)
    :ok
  end

  def new_data(record, data) do
    meta = get_meta(record)
    CubDB.put(__MODULE__, {record, meta.last_registered_id + 1}, data)
    {record, id} = update_meta(record, meta.last_registered_id + 1)
    get_data(record, id)
  end

  def update_data(record, id, data) do
    CubDB.put(__MODULE__, {record, id}, data)
    get_data(record, id)
  end

  def delete_data(record, id) do
    data = get_data(record, id)
    CubDB.delete(__MODULE__, {record, id})
    data
  end

  def get_data(record, id) do
    CubDB.get(__MODULE__, {record, id})
  end

  def get_meta(record) do
    CubDB.get(__MODULE__, {:meta_record, record}, MetaRecord.new)
  end

  def update_meta(record, last_registered_id) do
    CubDB.put(__MODULE__, {:meta_record, record}, %MetaRecord{last_registered_id: last_registered_id})
    {record, last_registered_id}
  end

  def struct_from_map(a_map, as: a_struct) do
    # Find the keys within the map
    keys = Map.keys(a_struct) |> Enum.filter(fn x -> x != :__struct__ end)
    # Process map, checking for both string / atom keys
    processed_map =
    for key <- keys, into: %{} do
      value = Map.get(a_map, key) || Map.get(a_map, to_string(key))
      {key, value}
    end
    a_struct = Map.merge(a_struct, processed_map)
    a_struct
  end
end