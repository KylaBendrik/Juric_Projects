defmodule TodoList.CsvImporter do
  def import(path) do
    data = File.stream!(path)
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> to_string
    
    
    my_new_list = TodoList.new()
    
    entries_list = format_entry(my_new_list, data)
    IO.inspect entries_list  
    my_new_list
  end
  
  defp format_entry(todo_list, []) do
    todo_list
  end
  
  defp format_entry(todo_list, [entry_csv]) do
    [date, title | tail] = String.split(entry_csv, ",", parts: 3)
    new_todo_list = TodoList.add_entry(todo_list, %{date: date, title: title})
    format_entry(new_todo_list, tail)
  end
  defp format_entry(todo_list, entry_csv), do: format_entry(todo_list, [entry_csv])
end
