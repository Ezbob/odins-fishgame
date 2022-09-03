package timer

import rl "vendor:raylib"

Timer :: f32

tick :: proc(timer: ^Timer) {
  timer^ += rl.GetFrameTime()
}

reset :: proc(timer: ^Timer) {
  timer^ = 0.0
}

when_expired :: proc(timer: ^Timer, sec: f32) -> bool {
  tick(timer)
  if is_expired(timer, sec) {
    reset(timer)
    return true
  }
  return false
}

is_expired :: proc(timer: ^Timer, sec: f32) -> bool {
  return timer^ > sec
}