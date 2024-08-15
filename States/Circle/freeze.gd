extends State
class_name Freeze

@export var main_canva: Node2D
@export var circle: Node2D

func update(delta):
	if not main_canva.start_animation:
		circle.change_details()

func _on_start_button_button_down():
	state_transition.emit(self, "Animate")


func _on_restart_button_button_down():
	state_transition.emit(self, "Restart")
