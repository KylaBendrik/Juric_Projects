defmodule TodoServer do
  def start do
    #spawn(fn -> loop(TodoList.new()) end)
    ServerProcess.start(TodoServer)
  end
  
  def init do
    TodoList.new()
  end
  
  # actions require a pair of new functions,
  # one interface function and one handle_call or handle_cast
  # we have four main actions:
  # - add_entry
  # - entries
  # - update_entry
  # - delete_entry
  
  def add_entry(todo_server, new_entry) do
    ServerProcess.cast(todo_server, {:add_entry, new_entry})
  end
  def entries(todo_server, date) do
    ServerProcess.call(todo_server, {:entries, date})
  end
  def update_entry(todo_server, entry_id, updater_fun) do
    ServerProcess.cast(todo_server, {:update_entry, entry_id, updater_fun})
  end
  def delete_entry(todo_server, entry_id) do
    ServerProcess.cast(todo_server, {:delete_entry, entry_id})
  end
  
  # callback functions
  def handle_cast({:add_entry, new_entry}, todo_list) do
    TodoList.add_entry(todo_list, new_entry)
  end
  
  def handle_cast({:update_entry, entry_id, updater_fun}, todo_list) do
    TodoList.update_entry(todo_list, entry_id, updater_fun)
  end
  
  def handle_cast({:delete_entry, entry_id}, todo_list) do
    TodoList.delete_entry(todo_list, entry_id)
  end
  
  def handle_call({:entries, date}, todo_list) do
    TodoList.entries(todo_list, date)
  end
  

end
