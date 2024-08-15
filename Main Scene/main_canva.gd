extends Node2D

@export var big_circle : Node2D
@export var small_circle : CharacterBody2D

var start_animation = false

func _ready():
	pass
	
func _process(delta):
	pass

func _draw():
	var center = Vector2(big_circle.position.x, big_circle.position.y)
	var radius = big_circle.radius
	var border = big_circle.border
	draw_circle(center, radius+border, Color(big_circle.red, big_circle.green, big_circle.blue))
	draw_circle(center, radius, Color(0, 0, 0))
	
	center = Vector2(small_circle.position.x, small_circle.position.y)
	radius = small_circle.radius
	border = small_circle.border
	draw_circle(center, radius, Color(small_circle.red_r, small_circle.green_r, small_circle.blue_r))
	draw_circle(center, radius-border, Color(small_circle.red, small_circle.green, small_circle.blue))


