package animation

import "../timer"

Anint :: struct {
  timer: timer.Timer,
  frameRate: f32,
  seqMin, seqMax, accumulator: int
}

Anint_create :: proc(seqMin: int, seqMax: int, frameRate: f32) -> Anint {
  return Anint {
    seqMin=seqMin,
    seqMax=seqMax,
    accumulator=seqMin,
    frameRate=frameRate,
  }
}

Anint_loop_forward :: proc(animation: ^Anint) -> int {
  if timer.when_expired(&animation.timer, animation.frameRate) {
    animation.accumulator = animation.accumulator + 1 if animation.accumulator < animation.seqMax else animation.seqMin
  }
  return animation.accumulator
}

Anint_loop_backward :: proc(animation: ^Anint) -> int {
  if timer.when_expired(&animation.timer, animation.frameRate) {
    animation.accumulator = animation.accumulator - 1 if animation.accumulator <= animation.seqMin else animation.seqMax
  }
  return animation.accumulator
}

Anint_reset :: proc(animation: ^Anint) {
  animation.accumulator = animation.seqMin
}

Anint_set_frame_rate :: proc(animation: ^Anint, frameRate: f32) {
  animation.frameRate = frameRate
}
