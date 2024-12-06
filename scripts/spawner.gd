extends Node2D
 
@export var player : CharacterBody2D
@export var enemy : PackedScene
 
@export var enemy_types : Array[Enemy]
 
var distance : float = 400
var can_spawn : bool = true
 
var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)
 
var second : int:
	set(value):
		second = value
		#if second >= 10:
			#second -= 10
			#minute += 1
		if second >= 60:
			second -= 60
			minute += 1
		%Second.text = str(second).lpad(2,'0')
 
func _physics_process(_delta):
	if get_tree().get_node_count_in_group("Enemy") < 700:
		can_spawn = true
	else:
		can_spawn = false
 
func spawn(pos : Vector2, elite : bool = false):
	#if not can_spawn and not elite:
		#return
 
	var enemy_instance = enemy.instantiate()
	var min_value_pick = min(minute/2, enemy_types.size() -1);
	var enemy_type = enemy_types.slice(0,min_value_pick + 1).pick_random()
	enemy_instance.type = enemy_type
	#enemy_instance.position = get_random_position()
	var added_health = (enemy_type.health * (minute *.5))
	enemy_instance.health = enemy_instance.health
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	enemy_instance.elite = elite
	get_tree().current_scene.add_child(enemy_instance)
 
func _on_timer_timeout():
	second += 1
	amount(second % 10)
 
 
func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
 
 
func amount(number : int = 1):
	for i in range(minute + (number * .4)):
		spawn(get_random_position())
 
 
func _on_pattern_timeout():
	for i in range(75):
		spawn(get_random_position())
 
 
func _on_elite_timeout():
	spawn(get_random_position(), true)
