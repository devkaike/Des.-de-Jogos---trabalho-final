extends CharacterBody2D
 
var player_reference : CharacterBody2D
var direction : Vector2
var speed : float = 75
var damage : float = 0
var knockback : Vector2
var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://Shader/Rainbow.tres")
			scale = Vector2(1.5,1.5)
 
 
func _physics_process(delta):
	var separation = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
 
	velocity = (player_reference.position - position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	var collider = move_and_collide(velocity * delta)
	if collider:
		collider.get_collider().wddknockback = (collider.get_collider().global_position - global_position).normalized() * 50
