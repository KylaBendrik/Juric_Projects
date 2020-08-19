defmodule KeyValueStoreTest do
  use ExUnit.Case
  doctest KeyValueStore

  describe "KeyValue Store" do
    setup do
      :ok
    end

    # @tag :pending
    test ":put and :get work as expected", _context do
      pid = ServerProcess.start(KeyValueStore)

      assert :ok == ServerProcess.call(pid, {:put, :some_key, :some_value})
      assert :some_value == ServerProcess.call(pid, {:get, :some_key})
    end
  end
end
