package entity

import rl "vendor:raylib"

Entity :: struct {
  id: u64,
  name: string,
  variant: union {^Fish, ^Player},
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

update :: proc(e: ^Entity) {
  switch v in e.variant {
    case ^Fish:
      Fish_update(v)
    case ^Player:
      Player_update(v)
  }
}

render :: proc(e: ^Entity) {
  switch v in e.variant {
    case ^Fish:
      Fish_render(v)
    case ^Player:
      Player_render(v)
  }
}
