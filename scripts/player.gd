extends CharacterBody2D
 
var health : float = 100 :
	set(value):
		health = max(value,0)
		%Health.value = value

var armor:float = 0
var might:float = 1.5
var area: float = 50

var max_health : float = 100.0 :
	set(value):
		max_health = value
		%Health.max_value = value
		
var movement_speed:float = 150
var recovery: float = 0
var magnet: float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 50 + value
var growth: float = 1

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0

var level : int = 1:
	set(value):
		level = value
		%Level.text ="Lv " + str(value)
		%Options.show_option()
		if level >= 2:
			%XP.max_value = 20
		elif level >= 7:
			%XP.max_value = 40
			
			
var nearest_enemy: CharacterBody2D
var nearest_enemy_distance: float = 150 + area

func _physics_process(delta):
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
	else:
		nearest_enemy_distance = 150 + area
		nearest_enemy = null
	velocity = Input.get_vector("left","right","up","down") * movement_speed
	move_and_collide(velocity * delta)
	#if velocity == Vector2.ZERO:
		#$AnimationPlayer.play("idle")
	#else:
		#$AnimationPlayer.play("run")
 #
	#if velocity.x < 0:
		#$Sprite2D.flip_h = true
	#elif velocity.x > 0:
		#$Sprite2D.flip_h = false
	check_XP()
	health += recovery * delta

	
func take_damage(amount):
	health -= max(amount - armor,0)
 
 
func _on_self_damage_body_entered(body):
	take_damage(body.damage)
 
func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth
	
func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		%XP.max_value = %XP.max_value * 1.5
		level += 1

func _on_timer_timeout() -> void:
	$"%Collision".set_deferred("disabled",true)
	$"%Collision".set_deferred("disabled",false)
	


func _on_magnet_area_entered(area: Area2D) -> void:
	if area.has_method("follow"):
		area.follow(self)
