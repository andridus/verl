module main
import erl


  fn sum_internal(a int, b int) int {
    println("Olá mundo ")
  return a + b

  }

  fn sum(env &erl.Env, arity int, args &erl.DynamicTerm ) !erl.DynamicTerm {
    if arity == 2 {
      
        a := erl.get_int(env, args, 0)!.to_int()!
      
        b := erl.get_int(env, args, 1)!.to_int()!
      
      result := sum_internal(a, b)
      return erl.make_int(env, result)
    } else {
      return error("badarg")
    }
  }

  fn sum_exported(env &erl.Env, arity int, args &erl.DynamicTerm ) erl.DynamicTerm {
    return sum(env, arity, args) or {
      erl.make_badarg(env)
    }
  }


@[export: 'nif_init']
fn start_nif() &erl.Entrypoint {
	functions := [
    
		  erl.Function{ name: c'sum', arity: 2, fptr: sum_exported, flags: 0}
    
	]
	return erl.init_entrypoint('Elixir.ExampleTest', functions)

}