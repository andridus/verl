module erl

#include <@VMODROOT/c_erl/erl_nif.h>

pub fn init_entrypoint(name string, functions []Function) &Entrypoint {
	entry := Entrypoint{
		major: 2
		minor: 17
		name: name.str
		num_of_funcs: functions.len
		funcs: functions.data
		vm_variant: c'beam.vanilla'
		options: 1
		sizeof_erl_nif_resource_type_init: sizeof(ResourceTypeInit)
		min_erts: c'erts-14.0'
	}
	return &entry
}