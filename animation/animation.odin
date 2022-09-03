package animation

import "../timer"

Anint :: struct {
  timer: timer.Timer,
  seqMin, seqMax, accumulator: int
}

Anint_make :: proc(seqMin: int, seqMax: int) -> Anint {
  return Anint {
    seqMin=seqMin,
    seqMax=seqMax,
    accumulator=seqMin,
  }
}

Anint_loop_forward :: proc(animation: ^Anint, frameTime: f32) -> int {
  if timer.when_expired(&animation.timer, frameTime) {
    animation.accumulator = animation.accumulator + 1 if animation.accumulator < animation.seqMax else animation.seqMin
  }
  return animation.accumulator
}

Anint_loop_backward :: proc(animation: ^Anint, frameTime: f32) -> int {
  if timer.when_expired(&animation.timer, frameTime) {
    animation.accumulator = animation.accumulator - 1 if animation.accumulator <= animation.seqMin else animation.seqMax
  }
  return animation.accumulator
}

create :: proc {Anint_make}

loop_forward :: proc {Anint_loop_forward}

loop_backward :: proc {Anint_loop_backward}