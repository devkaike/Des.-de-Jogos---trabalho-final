extends Weapon
class_name SingleShot
 
func shoot(source, target, scene_tree):
	if target == null:
		return
 
	var projectile = projectile_node.instantiate()
 
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.size = size
	projectile.ignore_colision = ignore_colision
	projectile.direction = (target.position - source.position).normalized()
	if(projectile_sprite):
		projectile.sprite = projectile_sprite
	scene_tree.current_scene.add_child(projectile)
 
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)

func upgrade_item():
	if max_level_reached():
		slot.item = evolution
		return
	
	if not is_upgrabled():
		return
	
	var upgrade = upgrades[level - 1]
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	size += upgrade.size
	
	level += 1
