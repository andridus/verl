defmodule Verl.Compiler do
  @moduledoc """
    Generate .v file and compile the V code in binary .so
  """

  require Logger

  defmacro __before_compile__(%{module: module}) do
    dir = File.cwd!() <> "/libv"
    functions = Module.get_attribute(module, :verl_code) # {fun_name, args, return, code}
    compile(module, functions, dir)
  end

  def compile(module, functions, dir) do
    module_str = module |> to_string() |> String.downcase() |> String.replace(".", "_")
    nif_path =  Path.join(dir, "#{module_str}.v")
    full_code = Verl.Module.render_v(functions, module)
    File.write!(nif_path, full_code)
    Logger.debug("Wrote: #{nif_path}")
    build(module_str)
    :ok
  end
  def build(file) do
    src = file <> ".v"
    dest = file <> ".so"
    args = ~w(-cc gcc -shared -o bin/#{dest} libv/#{src})
    {"", 0} = System.cmd("v", args)
    Logger.debug("build Nif with success!")
  end

end