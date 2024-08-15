extends AudioStreamPlayer2D

var time_to_vanish = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_to_vanish-=delta
	if time_to_vanish<=0:
		queue_free()
