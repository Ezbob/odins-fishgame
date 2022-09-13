package entity

import rl "vendor:raylib"
import "../components"

Fish :: struct {
  using entity: Entity,
  using movable: components.Movable,
  color: rl.Color,
}

Fish_update :: proc(f: ^Fish) {
  f.position += (f.velocity * rl.GetFrameTime())
}

Fish_render :: proc(f: ^Fish) {
  
}