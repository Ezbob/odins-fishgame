package control

import rl "vendor:raylib"

KeyBindings :: map[Actions]rl.KeyboardKey

DefaultKeyBoardInputDevice := InputDevice {
  bindings = map[Actions]rl.KeyboardKey {
    Actions.LEFT = rl.KeyboardKey.LEFT,
    Actions.RIGHT = rl.KeyboardKey.RIGHT,
    Actions.UP = rl.KeyboardKey.UP,
    Actions.DOWN = rl.KeyboardKey.DOWN,
  },
}

KeyBoard_isPressed :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case KeyBindings:
      val, ok := binding[action]
      if !ok {
        return false
      }
      return rl.IsKeyPressed(val)
  }
  return false
}

KeyBoard_isDown :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case KeyBindings:
      val, ok := binding[action]
      if !ok {
        return false
      }
      return rl.IsKeyDown(val)
  }
  return false
}

KeyBoard_isReleased :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case KeyBindings:
      val, ok := binding[action]
      if !ok {
        return false
      }
      return rl.IsKeyReleased(val)
  }
  return false
}