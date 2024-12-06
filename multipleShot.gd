extends Weapon
class_name MultipleShot

@export var pellets : int = 5  # Número de projéteis disparados por vez
@export var spread_angle : float = 15.0  # Ângulo de dispersão dos projéteis

func shoot(source, target, scene_tree):
	if target == null:
		return
	
	# Calcular a direção base para o disparo
	var direction = (target.position - source.position).normalized()

	# Disparar múltiplos projéteis com dispersão
	for i in range(pellets):
		# Calcular um pequeno desvio de ângulo para a dispersão
		var angle_offset = randf_range(-spread_angle, spread_angle)
		var direction_with_spread = direction.rotated(deg_to_rad(angle_offset))
		
		# Instanciar o projétil e configurar suas propriedades
		var projectile = projectile_node.instantiate()
		projectile.position = source.position
		projectile.damage = damage
		projectile.speed = speed
		projectile.source = source
		projectile.size = size
		projectile.ignore_colision = ignore_colision
		projectile.direction = direction_with_spread
		if(projectile_sprite):
			projectile.sprite = projectile_sprite
		# Adicionar o projétil à cena
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
	pellets += upgrade.pellets  # Aumenta o número de projéteis disparados
	spread_angle += upgrade.spread_angle  # Aumenta o ângulo de dispersão
	
	level += 1
