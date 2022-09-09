package entity

import rl "vendor:raylib"

Entity :: struct {
  id: u64,
  name: string,
  variant: union {^Fish},
}

@(private)
next_id: u64 = 0

new_entity :: proc($T: typeid) -> ^T {
  e := new(T)
  e.variant = e
  e.id = next_id
  next_id += 1
  return e
}
