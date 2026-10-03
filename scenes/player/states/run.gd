extends PlayerState

func _enter() -> void:
	obj.change_animation("run")

func _update(delta: float):
	if Input.is_action_pressed("sprint"):
		obj.anim_player.speed_scale = 1.6
	else:
		obj.anim_player.speed_scale = 1.0
	if control_jump():
		return
	if not control_moving():
		change_state(fsm.states.idle)
	if not obj.is_on_floor():
		change_state(fsm.states.fall)

func _exit() -> void:
	obj.anim_player.speed_scale = 1.0
