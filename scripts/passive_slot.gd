extends PanelContainer
#class_name PassiveSlot 
@export var player: CharacterBody2D

@export var item : PassiveItem:
	set(value):
		item = value
		$TextureRect.texture = value.texture
		print("PLAYER ",player )
		if(player):
			value.player_reference = player
		else:
			value.player_reference = owner
 
func _ready():
	if item != null:
		if(player):
			item.player_reference = player
		else:
			item.player_reference = owner
 
