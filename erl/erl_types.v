module erl


pub enum Encoding {
	latin1 = 1
	utf8 = 2
}

struct ResourceTypeInit {
    dtor &u8
    stop &u8
    down &u8
    members int
    dyncall &u8
}

pub type Function = C.ErlNifFunc

pub struct Entrypoint {
	major int
	minor int
	name &u8 = unsafe { nil }
	num_of_funcs int
	funcs &u8 = unsafe { nil }
	load fn(&C.ErlNifEnv, &voidptr, DynamicTerm) int = unsafe { nil }
	reaload fn(&C.ErlNifEnv, &voidptr, DynamicTerm) int = unsafe { nil }
	upgrade fn(&C.ErlNifEnv, &voidptr, &voidptr, DynamicTerm) int = unsafe { nil }
	unload fn(&C.ErlNifEnv, voidptr, DynamicTerm) = unsafe { nil }
	vm_variant &u8 = unsafe { nil }
	options u8
	sizeof_erl_nif_resource_type_init u32
	min_erts &u8 = unsafe { nil }
}

pub type Env = C.ErlNifEnv