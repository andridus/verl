module erl

pub fn make_badarg(env &Env) DynamicTerm {
	return C.enif_make_badarg(env)
}

pub fn make_string(env &Env, s string, enc Encoding) DynamicTerm {
	return C.enif_make_string(env, s.str, enc)
}

pub fn make_int(env &Env, i int) DynamicTerm {
	return C.enif_make_int(env, i)
}
