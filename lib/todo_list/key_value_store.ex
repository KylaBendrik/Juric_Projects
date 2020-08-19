defmodule KeyValueStore do
  use GenServer
  # interface functions
  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end
  
  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end
  
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
  
  # callback functions used internally by the generaic code.
  def init(_) do
    {:ok, %{}}
  end
  
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end
  
  def handle_call({:get, key}, _request_id, state) do
    {:reply, Map.get(state, key), state}
  end
end
