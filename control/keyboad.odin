package control

import rl "vendor:raylib"

KeyBindings :: map[Actions]rl.KeyboardKey

DefaultKeyBindings := map[Actions]rl.KeyboardKey {
  Actions.LEFT = rl.KeyboardKey.LEFT,
  Actions.RIGHT = rl.KeyboardKey.RIGHT,
  Actions.UP = rl.KeyboardKey.UP,
  Actions.DOWN = rl.KeyboardKey.DOWN,
}

DefaultKeyInputDevice := InputDevice {
  bindings = &DefaultKeyBindings,
}

KeyBoard_isPressed :: proc(binding: ^KeyBindings, action: Actions) -> bool {
  val, ok := binding[action]
  if !ok {
    return false
  }
  return rl.IsKeyPressed(val)
}

KeyBoard_isDown :: proc(binding: ^KeyBindings, action: Actions) -> bool {
  val, ok := binding[action]
  if !ok {
    return false
  }
  return rl.IsKeyDown(val)
}

KeyBoard_isReleased :: proc(binding: ^KeyBindings, action: Actions) -> bool {
  val, ok := binding[action]
  if !ok {
    return false
  }
  return rl.IsKeyReleased(val)
}