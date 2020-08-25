defmodule TodoServer do
  use GenServer
  def start do
    #spawn(fn -> loop(TodoList.new()) end)
    GenServer.start(__MODULE__, nil)
  end
  
  def add_entry(server, new_entry) do
    GenServer.cast(server,  {:add_entry, new_entry})
  end
  def entries(server, date) do
    GenServer.call(server,  {:entries, date})
  end
  def update_entry(server, entry_id, updater_fun) do
    GenServer.cast(server,  {:update_entry, entry_id, updater_fun})
  end
  def delete_entry(server, entry_id) do
    GenServer.cast(server, {:delete_entry, entry_id})
  end
  
  
  
  # actions require a pair of new functions,
  # one interface function and one handle_call or handle_cast
  # we have four main actions:
  # - add_entry
  # - entries
  # - update_entry
  # - delete_entry
  
  
  
  # callback functions
  @impl GenServer
  def init(_) do
    {:ok, TodoList.new()}
  end
  
  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, TodoList.add_entry(todo_list, new_entry)}
  end
  
  @impl GenServer
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    {:noreply, TodoList.update_entry(todo_list, entry_id, updater_fun)}
  end
  
  @impl GenServer
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, TodoList.delete_entry(todo_list, entry_id)}
  end
  
  @impl GenServer
  def handle_call({:entries, date},_request_id, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
  

end
