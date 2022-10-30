package entity

import rl "vendor:raylib"
import "../animation"
import "../components"
import spa "../spritesheetanimation"
import "../spritesheet"
import "../control"
import "core:math"

Player_Shared :: struct {
  animation: spa.SpriteSheetAnimations,
  input: ^control.InputDevice,
}

Player_State :: enum {
	STOPPED,
	STOPPING,
	SAILING,
}

Player :: struct {
  using entity: Entity,
  using movable: components.Movable,
  color: rl.Color,
  shared: ^Player_Shared,
  state: Player_State,
  playerNumber: uint,
}

default_player_shared := Player_Shared{
  input = &control.DefaultKeyInputDevice,
}

Player_new :: proc(number: uint) -> ^Player {
  e := new_entity(Player)
  e.playerNumber = number
  e.shared = &default_player_shared
  e.state = Player_State.STOPPED
  return e
}

Player_init_shared :: proc() {
  default_player_shared.animation = spa.load(sheetFilePath="assets/baad.png", frameWidth=90, frameHeight=55, rows=12, columns=2)

  spa.add_animation(&default_player_shared.animation, "sailing", 5, 11)
  spa.add_animation(&default_player_shared.animation, "start_sailing", 1, 5)
}

Player_deinit_shared :: proc() {
  spa.unload(&default_player_shared.animation)
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
  
  #partial switch p.state {
    case .SAILING:
      if (math.abs(p.velocity.x) < 1.6e-05) {
    	p.state = Player_State.STOPPING
      }
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
