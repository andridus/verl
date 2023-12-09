defmodule Verl do
  @moduledoc """
  Documentation for `Verl`.
  """
  defmacro __using__(_opts) do
    module = __CALLER__.module
    module_str = module |> to_string() |> String.downcase() |> String.replace(".", "_")
    quote do
      Module.register_attribute(__MODULE__, :verl_code, accumulate: true)
      import Verl, only: [nif: 1]
      @before_compile Verl.Compiler
      @on_load :init_nif

      def init_nif do
        :erlang.load_nif("bin/#{unquote(module_str)}", 0)
      end
    end
  end
  defmacro nif([do: {:def, _, [{:"::", _, [{fun_name, _, args}, {return, _, _} ]}, [do: code]]}]) do
    {args_ex, args_v}  = Enum.reduce(args, {[], []}, fn
      {:"::", _meta, [{key, _, _} = arg, {type, _, _}]}, {acc_ex, acc_v} ->
        {[arg|acc_ex], [{key, type}|acc_v]}
      _, _ -> raise "Invalid function arguments"
    end)

    {args_ex1, args_v1} = {Enum.reverse(args_ex), Enum.reverse(args_v)}

    quote do
      @verl_code {unquote(fun_name), unquote(args_v1), unquote(return), unquote(code)}
      def unquote(fun_name)(unquote_splicing(args_ex1)) do
        raise "the NIF function `#{unquote(fun_name)}/#{length(unquote(args_ex1))}` was not implemented"
      end
    end
  end
end
