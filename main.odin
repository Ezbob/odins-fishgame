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

  f := entity.new_entity(entity.Fish)

  InitWindow(800, 600, "example")
  defer CloseWindow()

  sp := spa.load(sheetFilePath="assets/baad.png", frameWidth=90, frameHeight=55, rows=12, columns=2)
  defer spa.unload(&sp)

  spa.add_animation(&sp, "sailing", 5, 11)
  spa.add_animation(&sp, "start_sailing", 1, 5)

  SetTargetFPS(60)

  for !shouldExit {
    if (IsKeyPressed(KeyboardKey.ESCAPE)) {
      shouldExit = true;
    }

    BeginDrawing()
    ClearBackground(BLUE)
    spritesheet.render_cutout(sheet=&sp, position=Vector2{0,0}, col=1, row=spa.loop_forward(&sp, "sailing", 0.2))
    EndDrawing()
  }

}