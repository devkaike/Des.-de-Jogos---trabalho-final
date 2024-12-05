extends VBoxContainer
 
@export var weapons : HBoxContainer
@export var passive_items : HBoxContainer
@export var avaliable_weapons : Array[Weapon]
@export var avaliable_passive_item : Array[PassiveItem]
var OptionSlot = preload("res://scenes/option_slot.tscn")
 
func _ready():
	hide()
 
func close_option():
	hide()
	get_tree().paused = false
 
func get_available_resource_in(items)-> Array[Item]:
	var resources : Array[Item] = []
	for item in items.get_children():
		if item.item != null:
			resources.append(item.item)
	return resources
 
func add_option(item) -> int:
	if item.is_upgrabled():
		var option_slot = OptionSlot.instantiate()
		option_slot.item = item
		add_child(option_slot)
		return 1
	return 0
 

func show_option():
	var weapons_available = get_available_resource_in(weapons)
	var passive_item_available = get_available_resource_in(passive_items)
	
	if weapons_available.size() == 0 and passive_item_available.size() == 0:
		return

	# Limpar os slots existentes
	for slot in get_children():
		slot.queue_free()
	
	var avaliable_items = []
	avaliable_items.append_array(avaliable_weapons)
	avaliable_items.append_array(avaliable_passive_item)
	
	var option_size = 0
	
	for avaliable_item in avaliable_items:
		if option_size < 3:
			if avaliable_item is Weapon:
				# Verifica se o item já está no HBoxContainer
				#if avaliable_item not in weapons_available:
					## Cria uma nova instância de WeaponSlot
					#var weapon_slot = WeaponSlot.new()
					#weapon_slot.item = avaliable_item
					#weapons.add_child(weapon_slot) # Adiciona ao HBoxContainer de armas
					#weapons_available.append(avaliable_item) # Atualiza a lista de armas disponíveis
				
				option_size += add_option(avaliable_item)
				
				if avaliable_item.max_level_reached() and avaliable_item.item_needed in passive_item_available:
					var option_slot = OptionSlot.instantiate()
					option_slot.item = avaliable_item
					add_child(option_slot)
					option_size += 1
					
			elif avaliable_item is PassiveItem:
				# Verifica se o item já está no HBoxContainer
				#if avaliable_item not in passive_item_available:
					## Cria uma nova instância de OptionSlot
					#var passive_slot = PassiveSlot.new()
					#passive_slot.item = avaliable_item
					#passive_items.add_child(passive_slot) # Adiciona ao HBoxContainer de armas
					#passive_item_available.append(avaliable_item) # Atualiza a lista de armas disponíveis
				
				option_size += add_option(avaliable_item)
 
	if option_size == 0:
		return
 
	show()
	get_tree().paused = true

	
func get_available_upgrades()-> Array[Item]:
	var upgrades : Array[Item] = []
	for weapon : Weapon in get_available_resource_in(weapons):
		if weapon.is_upgrabled():
			upgrades.append(weapon)
	for passive_item : PassiveItem in get_available_resource_in(passive_items):
		if passive_item.is_upgrabled():
			upgrades.append(passive_item)
	return upgrades
 
