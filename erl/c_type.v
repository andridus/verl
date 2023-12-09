module erl

@[typedef]
struct C.ErlNifEnv {}

@[typedef]
struct C.ErlNifFunc{
	name &u8
	arity u8
	fptr fn(&C.ErlNifEnv, int, &DynamicTerm) DynamicTerm = unsafe { nil }
	flags u8
}