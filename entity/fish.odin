package entity

import rl "vendor:raylib"

Fish :: struct {
  using entity: Entity,
  position: rl.Vector2,
  velocity: rl.Vector2,
}
