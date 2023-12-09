module erl

pub fn get_int(env &Env, term &DynamicTerm, pos int) !Term {
	mut i := 0
	unsafe { term +=pos}
	res := C.enif_get_int(env, term, &i)
	if res == 0 { return error("badarg") }
	return Integer(i)
}