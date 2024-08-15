extends Node2D

@export var label: Label
@export var slider: HSlider



func is_rgb():
	slider.min_value = 0.00
	slider.max_value = 1.00
	slider.value = 0.00
	slider.step = 0.01
	
	
func _process(delta):
	label.text = name + str(" (", slider.value ,")")


func randomize_value():
	slider.value = randf_range(slider.min_value, slider.max_value)
