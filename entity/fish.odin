package entity

import rl "vendor:raylib"
import "../components"

Fish_Random_Movement :: enum u8 {
	UP,
	DOWN,
	RIGHT,
	LEFT,
	STOP,
}

Fish_Shared :: struct {
	weighted_movement: [len(Fish_Random_Movement)]struct {
		type:   Fish_Random_Movement,
		weight: u8,
	},
	bounding_box:      rl.Rectangle,
	swim_force:        rl.Vector2,
	movement_plane:    rl.Rectangle,
	value:             i32,
}

Fish :: struct {
	using entity:  Entity,
	using movable: components.Movable,
	color:         rl.Color,
	shared:        ^Fish_Shared,
}

Fish_update :: proc(f: ^Fish) {
	f.position += (f.velocity * rl.GetFrameTime())
}

Fish_render :: proc(f: ^Fish) {

}
