defmodule KeyValueStoreTest do
  use ExUnit.Case
  doctest KeyValueStore
  
  @moduletag timeout: 10000

  describe "KeyValue Store" do
    setup do
      :ok
    end

    # @tag :pending
    test ":put and :get work as expected", _context do
      pid = KeyValueStore.start

      KeyValueStore.put(pid, :some_key, :some_value)
      assert :some_value == KeyValueStore.get(pid, :some_key)
    end
  end
end
