package entity

import rl "vendor:raylib"
import "../animation"
import "../components"
import spa "../spritesheetanimation"
import "../spritesheet"

Player_Shared :: struct {
  animation: spa.SpriteSheetAnimations,
}

Player :: struct {
  using entity: Entity,
  using movable: components.Movable,
  color: rl.Color,
  shared: ^Player_Shared,
}

Player_update :: proc(p: ^Player) {
  p.position += p.velocity * rl.GetFrameTime()

  p.velocity *= 0.99
}

Player_render :: proc(p: ^Player) {
  spritesheet.render_cutout(
    sheet=&p.shared.animation,
    position=p.position,
    col=1,
    row=spa.loop_forward(&p.shared.animation, "sailing", 0.2),
    flipped=true,
  )
}