module erl


type Term = DynamicTerm | Integer
type DynamicTerm = &u32
type Integer = int

pub fn (t Term) to_int() !int {
	return match t {
		Integer { int(t) }
		else {
			error("badarg")
		}
	}
}
