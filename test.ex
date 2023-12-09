defmodule Test do
  @on_load :nif_init

  def nif_init do
    :erlang.load_nif("./elixir_test", 0)
  end
  def hello do
    raise "Esta função não foi implementada"
  end
  def sum(_a, _b) do
    raise "Esta função não foi implementada"
  end

  def func2 do
    raise "Esta função não foi implementada"
  end
end