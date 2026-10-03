extends PlayerState

func _enter() -> void:
	#Change animation to jump
	obj.change_animation("jump")

func _update(_delta: float) -> void:
	if control_jump():
		return

	control_moving()

	if obj.velocity.y < 0.0:
		change_state(fsm.states.fall)

	
