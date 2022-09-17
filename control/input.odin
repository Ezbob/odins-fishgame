package control


Actions :: enum {
  UP,
  DOWN,
  LEFT,
  RIGHT,
}

InputDevice :: struct {
  bindings: union {KeyBindings},
}

isPressed :: proc{KeyBoard_isPressed}

isDown :: proc{KeyBoard_isDown}

isReleased :: proc{KeyBoard_isReleased}