package main

import "core:fmt"
import "vendor:raylib"
import "timer"
import "spritesheet"
import "spritesheetanimation"
import "entity"
import "animation"

main :: proc() {
  using raylib
  using spritesheetanimation

  fmt.println("Hello world!")

  shouldExit := false

  f := entity.new_entity(entity.Fish)

  InitWindow(800, 600, "example")
  defer CloseWindow()

  sp := load(sheetFilePath="assets/baad.png", frameWidth=90, frameHeight=55, rows=12, columns=2)
  defer unload(&sp)

  add_animation(&sp, "sailing", 5, 11, .2)
  add_animation(&sp, "start_sailing", 1, 5, .2)

  SetTargetFPS(60)

  for !shouldExit {
    if (IsKeyPressed(KeyboardKey.ESCAPE)) {
      shouldExit = true;
    }

    BeginDrawing()
    ClearBackground(BLUE)
    spritesheet.render_cutout(sheet=&sp, position=Vector2{0,0}, col=1, row=loop_forward(&sp, "sailing"))
    EndDrawing()
  }

}