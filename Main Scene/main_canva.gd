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
	
	if small_circle.after_images_amount > 0:
		for after_circle in small_circle.after_images:
			radius = after_circle.radius
			border = after_circle.border
			center = after_circle.position
			draw_circle(center, radius, Color(after_circle.red_r, after_circle.green_r, after_circle.blue_r))
			draw_circle(center, radius-border, Color(after_circle.red, after_circle.green, after_circle.blue))
	radius = small_circle.radius
	border = small_circle.border
	center = small_circle.position
	draw_circle(center, radius, Color(small_circle.red_r, small_circle.green_r, small_circle.blue_r))
	draw_circle(center, radius-border, Color(small_circle.red, small_circle.green, small_circle.blue))
	

func _on_randomize_button_button_down():
	if not start_animation:
		var adjusters = $Adjusters.get_children()
		for adjuster in adjusters:
			adjuster.randomize_value()
		small_circle.change_details()
		big_circle.change_details()
