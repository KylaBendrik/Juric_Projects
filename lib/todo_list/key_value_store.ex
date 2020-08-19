defmodule KeyValueStore do
  
  # interface functions
  def start do
    ServerProcess.start(KeyValueStore)
  end
  
  def put(pid, key, value) do
    ServerProcess.call(pid, {:put, key, value})
  end
  
  def get(pid, key) do
    ServerProcess.call(pid, {:get, key})
  end
  
  # callback functions used internally by the generaic code.
  def init do
    %{}
  end
  
  def handle_call({:put, key, value}, state) do
    {:ok, Map.put(state, key, value)}
  end
  
  def handle_call({:get, key}, state) do
    {Map.get(state, key), state}
  end
end