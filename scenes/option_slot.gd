extends Button

@export var new_item:bool:
	set(value):
		new_item = value
		
@export var item_type:String:
	set(value):
		item_type = value

@export var item_container:HBoxContainer:
	set(value):
		item_container = value

		
@export var item : Item:
	set(value):
		item = value
		if value.upgrades.size() > 0 and value.upgrades.size() +1 != value.level:
			#texture_normal = value.texture
			%ItemRect.texture = value.texture
			$Label.text = "Lvl " + str(item.level)
			$Description.text = value.upgrades[value.level - 1].description
		else:
			#texture_normal = value.evolution.texture
			%ItemRect.texture = value.texture
			$Label.text = ""
			$Description.text = "EVOLUTION"
 	


func _on_gui_input(event: InputEvent) -> void:
	print('HERE')
	if event.is_action_pressed("click") and item:
		print("NEW ",new_item)
		print("ITEM ",item_type)
		print(item.title)
		
		if new_item:
			if item_type == "passiveItem":
				var PassiveSlot = preload("res://scenes/passive_slot.tscn")
				var passive_slot = PassiveSlot.instantiate()
				passive_slot.item = item
				passive_slot.player = get_tree().current_scene.get_node("Player")
				item_container.add_child(passive_slot) # Adiciona ao HBoxContainer de armas
				passive_slot.item.upgrade_item()

			elif item_type == "weapon":
				var WeaponSlot = preload("res://scenes/slot.tscn")
				var weapon_slot = WeaponSlot.instantiate()
				weapon_slot.item = item
				weapon_slot.player = get_tree().current_scene.get_node("Player")
				item_container.add_child(weapon_slot) # Adiciona ao HBoxContainer de armas
				weapon_slot.item.upgrade_item()
				
		else:
			print("UPGRADE")
			item.upgrade_item()
		get_parent().close_option()
