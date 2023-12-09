defmodule ExampleTest do

  use ExUnit.Case
  use Verl

  nif do
    def sum(a :: int, b :: int) :: int do
      """
        return a + b
      """
    end
    # def sub(a :: int, b :: int) :: int do
    #   """
    #     return a - b
    #   """
    # end
  end


  test "sum/2" do
    assert 3 = sum(1,2)
  end
end