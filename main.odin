package main

import "core:fmt"
import rl "vendor:raylib"
import "timer"
import "spritesheet"
import spa "spritesheetanimation"
import "entity"
import "animation"
import "control"

main :: proc() {

  shouldExit := false
  entities: [dynamic]entity.Entity

  rl.InitWindow(800, 600, "example")
  defer rl.CloseWindow()

  entity.init_shareds()
  defer entity.deinit_shareds()

  f := entity.Fish_new(entity.Fish_Type.Cod)
  f.active = true
  f.color = rl.WHITE
  f.velocity.x = 10.0

  f2 := entity.Fish_new(entity.Fish_Type.Puffer)
  f2.active = true
  f2.color = rl.WHITE
  f2.velocity.x = 10.0
  f2.position.x = 100
  f2.position.y = 20

  p := entity.Player_new(0)

  append(&entities, p)
  append(&entities, f)
  append(&entities, f2)

  rl.SetTargetFPS(60)

  for !shouldExit {
    if (rl.IsKeyPressed(rl.KeyboardKey.ESCAPE)) {
      shouldExit = true;
    }

    for _, i in entities {
      entity.update(&entities[i])
    }

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLUE)
    for _, i in entities {
      entity.render(&entities[i])
    }
    rl.EndDrawing()
  }

}
