extends CharacterBody2D

@export var bounce_sound: PackedScene
@export var circle_recipe: PackedScene

var gravity_strength = 50
var bounce_speed = 1200
var initial_velocity = Vector2(150, 100)
var size_change = 0.01
var bounce_speed_change = 0.01
var gravity_change = 0.00

@onready var after_images: Array[CircleRecipe] = []
@onready var red_r = 1.00
@onready var green_r = 1.00
@onready var blue_r = 1.00
@onready var red = 0.00
@onready var green = 0.00
@onready var blue = 1.00
@onready var border = 4
@onready var radius_percentage = 0.5
@onready var radius = 225

@onready var red_gain = 0.01
@onready var green_gain = 0.01
@onready var blue_gain = 0.01

@onready var after_images_amount = 0
@onready var after_images_delay = 0.05
@onready var time_for_image = 0.05

@export var big_circle: Node2D
@export var parent_canva: Node2D

@export var radius_adjuster: Node2D
@export var red_adjuster: Node2D
@export var green_adjuster: Node2D
@export var blue_adjuster: Node2D

@export var gravity_gain_adjuster: Node2D
@export var size_gain_adjuster: Node2D
@export var bounce_gain_adjuster: Node2D

@export var gravity_adjuster: Node2D
@export var bounce_adjuster: Node2D

@export var after_image_adjuster: Node2D

@export var red_gain_adjuster: Node2D
@export var green_gain_adjuster: Node2D
@export var blue_gain_adjuster: Node2D




func _ready():
	velocity = initial_velocity

	
	radius_adjuster.name = "Inner Circle Size"
	radius_adjuster.slider.min_value = 0.05
	radius_adjuster.slider.max_value = 0.95
	radius_adjuster.slider.step = 0.01
	radius_adjuster.slider.value = 0.5
	
	gravity_gain_adjuster.name = "Gravity Gain"
	gravity_gain_adjuster.slider.step = 0.01
	gravity_gain_adjuster.slider.min_value = -0.10
	gravity_gain_adjuster.slider.max_value = 0.10
	gravity_gain_adjuster.slider.value = 0.00
	
	bounce_gain_adjuster.name = "Bounce Gain"
	bounce_gain_adjuster.slider.step = 0.01
	bounce_gain_adjuster.slider.min_value = -0.10
	bounce_gain_adjuster.slider.max_value = 0.10
	bounce_gain_adjuster.slider.value = 0.01
	
	size_gain_adjuster.name = "Size Gain"
	size_gain_adjuster.slider.step = 0.01
	size_gain_adjuster.slider.min_value = -0.10
	size_gain_adjuster.slider.max_value = 0.10
	size_gain_adjuster.slider.value = 0.01
	
	gravity_adjuster.name = "Starting Gravity Strength"
	gravity_adjuster.slider.step = 1
	gravity_adjuster.slider.min_value = 1
	gravity_adjuster.slider.max_value = 300
	gravity_adjuster.slider.value = 20
	
	bounce_adjuster.name = "Starting Bounce Strength"
	bounce_adjuster.slider.step = 1
	bounce_adjuster.slider.min_value = 100
	bounce_adjuster.slider.max_value = 2000
	bounce_adjuster.slider.value = 1000
	
	after_image_adjuster.name = "After Images amount"
	after_image_adjuster.slider.step = 10
	after_image_adjuster.slider.min_value = 0
	after_image_adjuster.slider.max_value = 50
	after_image_adjuster.slider.value = 0
	
	
	red_adjuster.name = "[RGB] Red Value"
	red_adjuster.is_rgb()
	green_adjuster.name = "[RGB] Green Value"
	green_adjuster.is_rgb()
	blue_adjuster.name = "[RGB] Blue Value"
	blue_adjuster.is_rgb()
	blue_adjuster.slider.value = 1
	
	red_gain_adjuster.name = "[RGB] Red Gain"
	red_gain_adjuster.is_rgb()
	red_gain_adjuster.slider.value = 0.01
	red_gain_adjuster.slider.max_value = 0.20
	red_gain_adjuster.slider.min_value = -0.20
	
	green_gain_adjuster.name = "[RGB] Green Gain"
	green_gain_adjuster.is_rgb()
	green_gain_adjuster.slider.value = 0.01
	green_gain_adjuster.slider.max_value = 0.20
	green_gain_adjuster.slider.min_value = -0.20
	
	blue_gain_adjuster.name = "[RGB] Blue Gain"
	blue_gain_adjuster.is_rgb()
	blue_gain_adjuster.slider.value = 0.01
	blue_gain_adjuster.slider.max_value = 0.20
	blue_gain_adjuster.slider.min_value = -0.20
	
	for g in range(after_images_amount):
		add_afterimage()

func add_afterimage():
	var new_circle = circle_recipe.instantiate()
	new_circle.red_r = red_r
	new_circle.blue_r = blue_r
	new_circle.green_r = green_r
	new_circle.red = red
	new_circle.blue = blue
	new_circle.green = green
	new_circle.border = border
	new_circle.radius = radius
	new_circle.position = position
	after_images.append(new_circle)
	
func check_if_bounce(distance):
	if distance + radius + border >= big_circle.radius:
		var angle_to_center = get_angle_to_center()
		var normal = Vector2(cos(angle_to_center), sin(angle_to_center))
		velocity = velocity.bounce(normal)
		velocity = velocity.normalized()
		velocity *= bounce_speed
		update_after_bounce()
		var new_sound = bounce_sound.instantiate()
		add_child(new_sound)
		

func get_angle_to_center():
	var direction = global_position - big_circle.global_position
	var angle_radians = direction.angle()
	return angle_radians
	
func update_after_bounce():
	if size_change>0:
		var shift_distance = radius * size_change
		var direction_to_center = (big_circle.global_position - global_position).normalized()
		global_position += direction_to_center * shift_distance
	radius += radius*size_change
	bounce_speed += bounce_speed*bounce_speed_change
	gravity_strength += gravity_strength*gravity_change
	blue += blue_gain
	red += red_gain
	green += green_gain


	
func move_circle(delta):
	time_for_image -= delta
	var new_position = global_position + velocity * delta
	var big_circle_pos = big_circle.global_position
	var distance = new_position.distance_to(big_circle_pos)

	if distance + radius + border <= big_circle.radius:
		global_position = new_position
		if time_for_image <= 0:
			after_images.pop_front()
			add_afterimage()
			time_for_image = after_images_delay
	else:
		var direction = (new_position - big_circle_pos).normalized()
		global_position = big_circle_pos + direction * (big_circle.radius - radius)
		check_if_bounce(distance)



func change_details():
	radius = radius_adjuster.slider.value * big_circle.radius
	red = red_adjuster.slider.value
	green = green_adjuster.slider.value
	blue = blue_adjuster.slider.value
	size_change = size_gain_adjuster.slider.value
	bounce_speed_change = bounce_gain_adjuster.slider.value
	gravity_change = gravity_gain_adjuster.slider.value
	gravity_strength = gravity_adjuster.slider.value
	bounce_speed = bounce_adjuster.slider.value
	
	blue_gain = blue_gain_adjuster.slider.value
	red_gain = red_gain_adjuster.slider.value
	green_gain = green_gain_adjuster.slider.value
	
	after_images_amount = after_image_adjuster.slider.value
	after_images.clear()
	for g in range(after_images_amount):
		add_afterimage()
		

	

