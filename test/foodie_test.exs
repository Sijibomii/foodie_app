defmodule FoodieTest do
  use ExUnit.Case
  doctest Foodie

  test "greets the world" do
    assert Foodie.hello() == :world
  end
end
