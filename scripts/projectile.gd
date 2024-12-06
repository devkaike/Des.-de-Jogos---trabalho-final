extends Area2D
 
var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1
var source
var size:float = 1:
	set(value):
		size = value
		$CollisionShape2D.scale = Vector2(value,value)
		$Sprite2D.scale = Vector2(value,value)

var ignore_colision:bool = false
var sprite:Texture2D:
	set(value):
		sprite = value
		$Sprite2D.texture = value

func _physics_process(delta):
	position += direction * speed * delta
 
 
func _on_body_entered(body):
	if body.has_method("take_damage"):
		if "might" in source:
			body.take_damage(damage * source.might)
		else:
			body.take_damage(damage)
		body.knockback = direction * 90
		if(!ignore_colision):
			queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
		queue_free()
