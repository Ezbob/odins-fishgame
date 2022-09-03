package main

import "core:fmt"
import rl "vendor:raylib"
import "timer"
import "spritesheet"
import "entity"
import "animation"



main :: proc() {
  fmt.println("Hello world!")

  shouldExit := false

  f := entity.new_entity(entity.Fish)

  rl.InitWindow(800, 600, "example")
  defer rl.CloseWindow()

  baad := spritesheet.create(texture=rl.LoadTexture("assets/baad.png"), frameWidth=90, frameHeight=55, rows=12, columns=2)
  defer rl.UnloadTexture(baad.texture)

  ani := animation.create(0, 11)

  rl.SetTargetFPS(60)

  for !shouldExit {
    if (rl.IsKeyPressed(rl.KeyboardKey.ESCAPE)) {
      shouldExit = true;
    }

    r := animation.loop_forward(&ani, 1.0 / 10.0)

    rl.BeginDrawing()
    rl.ClearBackground(rl.BLUE)
    spritesheet.render_cutout(sheet=&baad, position=rl.Vector2{0,0}, col=1, row=r)
    rl.EndDrawing()
  }

}