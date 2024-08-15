extends Node2D

@export var parent_canva: Node2D

@onready var red = 1.00
@onready var green = 1.00
@onready var blue = 1.00
@onready var max_radius = 400
@onready var radius = 400
@onready var border = 4

@export var radius_adjuster: Node2D


func _ready():
	
	radius_adjuster.name = "Outer Circle Size"
	radius_adjuster.slider.value = 1.0
	radius_adjuster.slider.step = 0.01
	radius_adjuster.slider.min_value = 0.5
	radius_adjuster.slider.max_value = 1.0
	parent_canva.queue_redraw()


func _process(delta):
	if parent_canva.start_animation:
		pass
	else:
		change_details()
		parent_canva.queue_redraw()
	


func change_details():
	radius = radius_adjuster.slider.value * max_radius
