package spritesheetanimations

import "../spritesheet"
import "../animation"

SpriteSheetAnimations :: struct {
  using spritesheet: spritesheet.SpriteSheet,
  animations: map[string]animation.Anint,
}

load :: proc(sheetFilePath: cstring, frameWidth: int, frameHeight: int, columns: int, rows: int) -> SpriteSheetAnimations {
  return SpriteSheetAnimations {
    spritesheet = spritesheet.load(sheetFilePath, frameWidth, frameHeight, columns, rows),
    animations = make(map[string]animation.Anint, 0),
  }
}

unload :: proc(sp: ^SpriteSheetAnimations) {
  spritesheet.unload(sp)
  delete(sp.animations)
}

add_animation :: proc(spa: ^SpriteSheetAnimations, name: string, start: int, end: int) {
  spa.animations[name] = animation.Anint_create(start, end)
}

loop_forward :: proc(spa: ^SpriteSheetAnimations, name: string, rate: f32) -> int {
  return animation.Anint_loop_forward(&spa.animations[name], rate)
}

loop_backward :: proc(spa: ^SpriteSheetAnimations, name: string, rate: f32) -> int {
  return animation.Anint_loop_backward(&spa.animations[name], rate)
}