package entity

import rl "vendor:raylib"
import "../components"
import "../spritesheet"
import "../spritesheetanimation"

Fish_Random_Movement :: enum u8 {
	UP,
	DOWN,
	RIGHT,
	LEFT,
	STOP,
}

Fish_Type :: enum {
	Cod    = 0,
	Puffer = 1,
}

Fish_Shared :: struct {
	weighted_movement: [len(Fish_Random_Movement)]struct {
		type:   Fish_Random_Movement,
		weight: u8,
	},
	animation:         spritesheetanimation.SpriteSheetAnimations,
	fish_type:         Fish_Type,
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
	active:        bool,
}

cod_fish_shared := Fish_Shared {
	weighted_movement = [len(Fish_Random_Movement)]struct {
		type:   Fish_Random_Movement,
		weight: u8,
	}{{
			type = Fish_Random_Movement.UP,
			weight = 8,
		}, {type = Fish_Random_Movement.DOWN, weight = 12 + 8}, {type = Fish_Random_Movement.RIGHT, weight = 16 + 12 + 8}, {type = Fish_Random_Movement.LEFT, weight = 16 + 16 + 12 + 8}, {type = Fish_Random_Movement.LEFT, weight = 48 + 16 + 16 + 12 + 8}},
	swim_force = rl.Vector2{30, 30},
	movement_plane = rl.Rectangle{0, 120, 0, 0},
	value = 100,
	fish_type = Fish_Type.Cod,
}

puffer_fish_shared := cod_fish_shared

Fish_new :: proc(type: Fish_Type) -> ^Fish {
	switch type {
	case Fish_Type.Cod:
		e := new_entity(Fish)
		e.variant.(^Fish).shared = &cod_fish_shared
		return e
	case Fish_Type.Puffer:
		e := new_entity(Fish)
		e.variant.(^Fish).shared = &puffer_fish_shared
		return e
	}
	return nil
}

Fish_init_shared :: proc() {
	cod_fish_shared.movement_plane.width = f32(rl.GetScreenWidth())
	cod_fish_shared.movement_plane.height = f32(rl.GetScreenHeight())
	cod_fish_shared.animation = spritesheetanimation.load("assets/fish.png", 32, 32, 2, 3)
	spritesheetanimation.add_animation(&cod_fish_shared.animation, "swim", 0, 2)
	spritesheetanimation.add_animation(&cod_fish_shared.animation, "idle", 0, 0)

	puffer_fish_shared.swim_force = 20
	puffer_fish_shared.fish_type = Fish_Type.Puffer
	puffer_fish_shared.animation = cod_fish_shared.animation
	spritesheetanimation.add_animation(&puffer_fish_shared.animation, "swim", 0, 2)
	spritesheetanimation.add_animation(&puffer_fish_shared.animation, "idle", 0, 0)
}

Fish_deinit_shared :: proc() {
	spritesheetanimation.unload(&cod_fish_shared.animation)
}

Fish_update :: proc(f: ^Fish) {
	if (!f.active) {
		return
	}

	f.position += (f.velocity * rl.GetFrameTime())
	f.velocity *= 0.99

}

Fish_render :: proc(f: ^Fish) {
	spritesheet.render_cutout(
		&f.shared.animation,
		f.position,
		0,
		int(f.shared.fish_type),
		false,
		f.color,
	)
}
