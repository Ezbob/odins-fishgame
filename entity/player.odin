package entity

import rl "vendor:raylib"
import "../animation"

Player :: struct {
  using entity: Entity,
  position: rl.Vector2,
  velocity: rl.Vector2,
  color: rl.Color,
}