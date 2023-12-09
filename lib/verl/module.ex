defmodule Verl.Module do
  require EEx

  template = Path.join(__DIR__, "templates/main.v.heex")
  EEx.function_from_file(:def, :module_file, template, [:assigns])

  def render_v(functions, module) do
    module_file(binding())
  end
end