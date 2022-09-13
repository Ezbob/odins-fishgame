package entity

import rl "vendor:raylib"
import "../animation"
import "../components"
import spa "../spritesheetanimation"
import "../spritesheet"

Player :: struct {
  using entity: Entity,
  using movable: components.Movable,
  color: rl.Color,
  animation: ^spa.SpriteSheetAnimations,
}

Player_update :: proc(p: ^Player) {
  p.position += p.velocity * rl.GetFrameTime()

  p.velocity *= 0.99
}

Player_render :: proc(p: ^Player) {
  spritesheet.render_cutout(sheet=p.animation, position=p.position, col=1, row=spa.loop_forward(p.animation, "sailing", 0.2), flipped=true)
}