package spritesheetanimations

import "../spritesheet"
import "../animation"

SpriteSheetAnimations :: struct {
  using spritesheet: spritesheet.SpriteSheet,
  animations: map[string]animation.Anint
}

load :: proc(sheetFilePath: cstring, frameWidth: int, frameHeight: int, columns: int, rows: int) -> SpriteSheetAnimations {
  sp := spritesheet.load(sheetFilePath, frameWidth, frameHeight, columns, rows)
  return create(sp)
}

unload :: proc(sp: ^SpriteSheetAnimations) {
  spritesheet.unload(sp)
  delete(sp.animations)
}

create :: proc(sheet: spritesheet.SpriteSheet) -> SpriteSheetAnimations {
  return SpriteSheetAnimations {
    spritesheet = sheet,
    animations = make(map[string]animation.Anint, 0)
  }
}

add_animation :: proc(spa: ^SpriteSheetAnimations, name: string, start: int, end: int, rate: f32) {
  spa.animations[name] = animation.Anint_create(start, end, rate)
}

loop_forward :: proc(spa: ^SpriteSheetAnimations, name: string) -> int {
  return animation.Anint_loop_forward(&spa.animations[name])
}

loop_backward :: proc(spa: ^SpriteSheetAnimations, name: string) -> int {
  return animation.Anint_loop_backward(&spa.animations[name])
}