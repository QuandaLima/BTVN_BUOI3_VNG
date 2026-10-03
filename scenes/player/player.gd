extends BaseCharacter


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fsm = FSM.new(self, $States, $States/Idle, true)
	super._ready()
