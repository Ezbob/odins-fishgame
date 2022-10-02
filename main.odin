package main

import "core:fmt"
import "vendor:raylib"
import "timer"
import "spritesheet"
import spa "spritesheetanimation"
import "entity"
import "animation"
import "control"

main :: proc() {
  using raylib

  shouldExit := false
  entities: [dynamic]entity.Entity

  InitWindow(800, 600, "example")
  defer CloseWindow()

  entity.init_shareds()
  defer entity.deinit_shareds()

  f := entity.Fish_new(entity.Fish_Type.Cod)
  f.color = WHITE
  f.velocity.x = 10.0

  f2 := entity.Fish_new(entity.Fish_Type.Puffer)
  f2.color = WHITE
  f2.velocity.x = 10.0
  f2.position.x = 100
  f2.position.y = 20

  p := entity.Player_new(0)

  append(&entities, p)
  append(&entities, f)
  append(&entities, f2)

  SetTargetFPS(60)

  for !shouldExit {
    if (IsKeyPressed(KeyboardKey.ESCAPE)) {
      shouldExit = true;
    }

    for _, i in entities {
      entity.update(&entities[i])
    }

    BeginDrawing()
    ClearBackground(BLUE)
    for _, i in entities {
      entity.render(&entities[i])
    }
    EndDrawing()
  }

}