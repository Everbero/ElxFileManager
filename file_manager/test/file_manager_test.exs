defmodule FileManagerTest do
  use ExUnit.Case
  doctest FileManager

  test "greets the world" do
    assert FileManager.hello() == :world
  end
end
