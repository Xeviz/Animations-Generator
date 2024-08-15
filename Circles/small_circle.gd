extends CharacterBody2D

@export var bounce_sound: PackedScene

var gravity_strength = 50
var bounce_speed = 1200
var initial_velocity = Vector2(150, 100)

var size_change = 0.01
var bounce_speed_change = 0.01
var gravity_change = 0.00

@onready var red_r = 1.00
@onready var green_r = 1.00
@onready var blue_r = 1.00
@onready var red = 0.00
@onready var green = 0.00
@onready var blue = 1.00


@export var big_circle: Node2D
@export var parent_canva: Node2D


@onready var collision_shape = $CollisionShape2D
@onready var border = 4
@onready var radius_percentage = 0.5
@onready var radius = 225

@export var radius_adjuster: Node2D
@export var red_adjuster: Node2D
@export var green_adjuster: Node2D
@export var blue_adjuster: Node2D

@export var gravity_gain_adjuster: Node2D
@export var size_gain_adjuster: Node2D
@export var bounce_gain_adjuster: Node2D

@export var gravity_adjuster: Node2D
@export var bounce_adjuster: Node2D

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
	
	
	red_adjuster.name = "Inner Circle Red Value"
	red_adjuster.is_rgb()
	green_adjuster.name = "Inner Circle Green Value"
	green_adjuster.is_rgb()
	blue_adjuster.name = "Inner Circle Blue Value"
	blue_adjuster.is_rgb()

func _physics_process(delta):
	pass
	#if radius < 0.99 * big_circle.radius and parent_canva.start_animation:
		#velocity.y += gravity_strength
		#move_circle(delta)
		#parent_canva.queue_redraw()
	#elif radius >= 0.99 * big_circle.radius and parent_canva.start_animation:
		#parent_canva.is_stopped = true
	#elif parent_canva.is_stopped and not parent_canva.start_animation:
		#change_details()
		
	
	
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

	
func move_circle(delta):
	var new_position = global_position + velocity * delta
	var big_circle_pos = big_circle.global_position
	var distance = new_position.distance_to(big_circle_pos)

	if distance + radius + border <= big_circle.radius:
		global_position = new_position
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

