package main

import "core:fmt"
import "vendor:raylib"
import "timer"
import "spritesheet"
import spa "spritesheetanimation"
import "entity"
import "animation"

main :: proc() {
  using raylib

  fmt.println("Hello world!")

  shouldExit := false

  entities: [dynamic]entity.Entity

  f := entity.new_entity(entity.Fish)
  f.velocity.x = 10.0;

  InitWindow(800, 600, "example")
  defer CloseWindow()

  sp := spa.load(sheetFilePath="assets/baad.png", frameWidth=90, frameHeight=55, rows=12, columns=2)
  defer spa.unload(&sp)

  spa.add_animation(&sp, "sailing", 5, 11)
  spa.add_animation(&sp, "start_sailing", 1, 5)

  player_shared := entity.Player_Shared {
    animation = sp,
  }

  p := entity.new_entity(entity.Player)
  p.shared = &player_shared
  p.velocity.x = 20.0;

  append(&entities, p)

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