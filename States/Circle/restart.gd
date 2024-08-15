extends State
class_name Restart

@export var circle: Node2D
@export var main_canva: Node2D

func enter():
	circle.change_details()
	circle.position.x = 800
	circle.position.y = 450
	main_canva.start_animation = false

func update(delta):
	state_transition.emit(self, "Freeze")
