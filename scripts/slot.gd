extends PanelContainer
var player: CharacterBody2D 

@export var item: Weapon:
	set(value):
		item = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		item.slot = self

func _on_cooldown_timeout() -> void:
	if item:
		$Cooldown.wait_time = item.cooldown
		if(player):
			item.activate(player,player.nearest_enemy, get_tree())
		else:
			item.activate(owner,owner.nearest_enemy, get_tree())
