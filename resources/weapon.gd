extends Item
class_name Weapon

@export var damage : float
@export var cooldown : float
@export var speed : float
@export var ignore_colision:bool
@export var size:float = 1
@export var projectile_sprite:Texture2D

@export var projectile_node : PackedScene = preload("res://scenes/projectile.tscn")
@export var item_needed: PassiveItem
@export var upgrades: Array[Upgrade]
@export var evolution: Weapon

var slot

func activate(_source, _target, _scene_tree):
	pass

func is_upgrabled() -> bool:
	if level <= upgrades.size():
		return true
	return false

func upgrade_item():
	if not is_upgrabled():
		return
	
	var upgrade = upgrades[level - 1]
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	
	level += 1
	
func max_level_reached():
	if upgrades.size() +1 == level and upgrades.size() != 0:
		return true
	return false
