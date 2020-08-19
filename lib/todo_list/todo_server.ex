defmodule TodoServer do
  use GenServer
  def start do
    #spawn(fn -> loop(TodoList.new()) end)
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end
  
  def add_entry(new_entry) do
    GenServer.cast(__MODULE__, {:add_entry, new_entry})
  end
  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end
  def update_entry(entry_id, updater_fun) do
    GenServer.cast(__MODULE__, {:update_entry, entry_id, updater_fun})
  end
  def delete_entry(entry_id) do
    GenServer.cast(__MODULE__, {:delete_entry, entry_id})
  end
  
  
  
  # actions require a pair of new functions,
  # one interface function and one handle_call or handle_cast
  # we have four main actions:
  # - add_entry
  # - entries
  # - update_entry
  # - delete_entry
  
  
  
  # callback functions
  def init do
    TodoList.new()
  end
  
  def handle_cast({:add_entry, new_entry}, todo_list) do
    {:noreply, TodoList.add_entry(todo_list, new_entry)}
  end
  
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    {:noreply, TodoList.update_entry(todo_list, entry_id, updater_fun)}
  end
  
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    {:noreply, TodoList.delete_entry(todo_list, entry_id)}
  end
  
  def handle_call({:entries, date},_request_id, todo_list) do
    {:reply, TodoList.entries(todo_list, date), todo_list}
  end
  

end
