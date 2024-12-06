extends Item
class_name PassiveItem
 
@export var upgrades : Array[Stats]
var player_reference
 
func is_upgrabled() -> bool:
	if level <= upgrades.size():
		return true
	return false
 
func upgrade_item():
	print("IS UPGRADE ",player_reference)
	if not is_upgrabled():
		return
 
	if player_reference == null:
		return
 
	var upgrade = upgrades[level - 1]
 
	player_reference.max_health += upgrade.max_health
	player_reference.recovery += upgrade.recovery
	player_reference.armor += upgrade.armor
	player_reference.movement_speed += upgrade.movement_speed
	player_reference.might += upgrade.might
	player_reference.area += upgrade.area
	player_reference.magnet += upgrade.magnet
	player_reference.growth += upgrade.growth
 
	level += 1
