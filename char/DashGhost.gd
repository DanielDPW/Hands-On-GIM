extends Sprite2D
 
func _ready():
	randomize()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.6)
	tween.tween_callback(tween_all_completed)
 
func tween_all_completed():
	self.queue_free()
