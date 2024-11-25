extends Area2D
 
var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1
 
func _physics_process(delta):
	position += direction * speed * delta
 
 
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		body.knockback = direction * 90
 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
		queue_free()
