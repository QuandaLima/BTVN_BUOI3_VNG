class_name PlayerState
extends FSMState

func _enter() -> void:
	pass

func _exit() -> void:
	pass

func _update(delta: float) -> void:
	pass

#Control moving and changing state to run
#Return true if moving

func control_moving() -> bool:
	var input: Vector2 = Input.get_vector("left", "right", "up", "down")
	var is_moving: bool = input.length() > 0.1

	# Giữ Shift để tăng tốc độ lên 1.6 lần
	var speed: float = obj.movement_speed

	if Input.is_action_pressed("sprint"):
		speed *= 1.6

	if is_moving:
		obj.change_direction(BaseCharacter.direction_from_input(input))
		obj.velocity.x = speed * input.x
		obj.velocity.z = speed * input.y

		if obj.is_on_floor():
			change_state(fsm.states.run)

		return true
	else:
		obj.stop_horizontal()

	return false


#Control jumping
#Return true if jumping


func control_jump() -> bool:
	if not Input.is_action_just_pressed("jump"):
		return false

	if obj.jumps_used >= obj.max_jumps:
		return false

	# Nhảy lần đầu: đang đứng đất hoặc còn Coyote Time
	var can_first_jump: bool = (
		obj.jumps_used == 0
		and (obj.is_on_floor() or obj.coyote_timer > 0.0)
	)

	# Nhảy lần hai: đã nhảy một lần và đang trên không
	var can_double_jump: bool = (
		obj.jumps_used == 1
		and not obj.is_on_floor()
	)

	if can_first_jump or can_double_jump:
		obj.jump()
		change_state(fsm.states.jump)
		return true

	return false
