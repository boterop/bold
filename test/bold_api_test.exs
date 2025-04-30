defmodule BoldApiTest do
  use ExUnit.Case
  doctest BoldApi

  test "greets the world" do
    assert BoldApi.hello() == :world
  end
end
