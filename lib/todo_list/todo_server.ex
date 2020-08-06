defmodule TodoList.TodoServer do
  def start do
    spawn(fn -> loop(TodoList.new()) end)
  end
  
  defp loop(todo_list) do
    new_todo_list = 
    receive do
      message -> process_message(todo_list, message)
    end
    
    loop(new_todo_list)
  end
end
