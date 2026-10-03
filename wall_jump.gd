extends PlayerState

@export var horizontal_push: float = 8.0
@export var control_delay: float = 0.2

var lock_timer: float = 0.0

func _enter() -> void:
	obj.change_animation("jump")
	
	var direction: Vector3 = obj.wall_jump_normal
	direction.y = 0.0
	direction = direction.normalized()

	if direction.length_squared() < 0.001:
		change_state(fsm.states.fall)
		return

	obj.velocity.x = direction.x * horizontal_push
	obj.velocity.z = direction.z * horizontal_push

	obj.velocity.y = obj.jump_speed

	obj.jumps_used = obj.max_jumps

	lock_timer = control_delay

	print("Wall Jump!")


func _update(delta: float) -> void:
	if lock_timer > 0.0:
		lock_timer -= delta
		return

	if obj.is_on_floor():
		change_state(fsm.states.idle)
	elif obj.velocity.y <= 0.0:
		change_state(fsm.states.fall)
	else:
		change_state(fsm.states.jump)
