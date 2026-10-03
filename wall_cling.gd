
extends PlayerState

func _enter() -> void:
	obj.change_animation("fall")
	print("Cao dang bam tuong!")


func _update(_delta: float) -> void:
	if obj.is_on_floor():
		var input: Vector2 = Input.get_vector("left", "right", "up", "down")

		if input.length() > 0.1:
			change_state(fsm.states.run)
		else:
			change_state(fsm.states.idle)
		return
		
	if not obj.is_on_wall():
		change_state(fsm.states.fall)
		return

	if Input.is_action_just_pressed("jump"):
		obj.wall_jump_normal = obj.get_wall_normal()
		change_state(fsm.states.walljump)
		return

	obj.velocity.y = maxf(obj.velocity.y, -1.0)

	control_moving()


func _exit() -> void:
	print("Cao da roi khoi tuong!")
