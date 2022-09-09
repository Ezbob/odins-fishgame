package spritesheet

import rl "vendor:raylib"

SpriteSheet :: struct {
  texture: rl.Texture,
  frameWidth, frameHeight, columns, rows: int,
}

load :: proc(filepath: cstring, frameWidth: int, frameHeight: int, columns: int, rows: int) -> SpriteSheet {
  sp := SpriteSheet{}
  sp.texture = rl.LoadTexture(filepath)
  sp.frameWidth = frameWidth
  sp.frameHeight = frameHeight
  sp.columns = columns
  sp.rows = rows
  return sp
}

unload :: proc(sp: ^SpriteSheet) {
  rl.UnloadTexture(sp.texture)
}

create :: proc(texture: rl.Texture, frameWidth: int, frameHeight: int, columns: int, rows: int) -> SpriteSheet {
  return SpriteSheet {
    texture=texture,
    frameWidth=frameWidth,
    frameHeight=frameHeight,
    columns=columns,
    rows=rows,
  }
}

render_cutout :: proc(
    sheet: ^SpriteSheet, position: rl.Vector2, row: int = 0, col: int = 0, flipped: bool = false, color: rl.Color = rl.WHITE) {
  rl.DrawTextureRec(sheet.texture,
    rl.Rectangle {
      x = f32(col * sheet.frameWidth),
      y = f32(row * sheet.frameHeight),
      width = f32(-sheet.frameWidth if flipped else sheet.frameWidth),
      height = f32(sheet.frameHeight),
    },
    position,
    color
  )
}
