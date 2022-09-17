package entity

import rl "vendor:raylib"
import "../animation"
import "../components"
import spa "../spritesheetanimation"
import "../spritesheet"
import "../control"

Player_Shared :: struct {
  animation: spa.SpriteSheetAnimations,
  input: ^control.InputDevice,
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

  goingRight := control.isDown(p.shared.input, control.Actions.RIGHT)
  goingLeft := control.isDown(p.shared.input, control.Actions.LEFT)

  if (goingRight && !goingLeft) {
    p.velocity.x = 30
  } else if (goingLeft && !goingRight) {
    p.velocity.x = -30
  }
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