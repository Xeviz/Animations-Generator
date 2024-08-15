extends State
class_name Animate

@export var circle: Node2D
@export var main_canva: Node2D

func enter():
	main_canva.start_animation = true

func update(delta):
	if circle.radius < 0.99 * circle.big_circle.radius and circle.radius >1:
		circle.velocity.y += circle.gravity_strength
		circle.move_circle(delta)
		circle.parent_canva.queue_redraw()
	else:
		state_transition.emit(self, "Freeze")


func _on_stop_button_button_down():
	state_transition.emit(self, "Freeze")


func _on_restart_button_button_down():
	state_transition.emit(self, "Restart")
