package control


Actions :: enum {
  UP,
  DOWN,
  LEFT,
  RIGHT,
}

InputDevice :: struct {
  bindings: union {^KeyBindings},
}

isPressed :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case ^KeyBindings:
      return KeyBoard_isPressed(binding, action)
  }
  return false
}

isDown :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case ^KeyBindings:
      return KeyBoard_isDown(binding, action)
  }
  return false
}

isReleased :: proc(inp: ^InputDevice, action: Actions) -> bool {
  switch binding in inp.bindings {
    case ^KeyBindings:
      return KeyBoard_isReleased(binding, action)
  }
  return false
}