extends PlayerState

func _enter() -> void:
	obj.change_animation("fall")



func _update(_delta: float) -> void:
	if obj.is_on_wall() and not obj.is_on_floor() and obj.velocity.y < 0.0:
		change_state(fsm.states.wallcling)
		return

	if control_jump():
		return

	var is_moving: bool = control_moving()

	if obj.is_on_floor():
		if not is_moving:
			change_state(fsm.states.idle)
