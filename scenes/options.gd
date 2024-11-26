extends VBoxContainer

@export var waepons: HBoxContainer
var OptionSlot = preload('res://scenes/option_slot.tscn')

func _ready() -> void:
	hide()

func get_available_waepons():
	var weapon_resource = []
	for weapon in waepons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	return weapon_resource
	
func close_option():
	hide()
	get_tree().paused = false

func show_options():
	#var option_slot = OptionSlot.instantiate()
	#add_child(option_slot)
	#
	#show()
	#get_tree().paused = true
	var weapons_available = get_available_waepons()
	if weapons_available.size() == 0:
		return
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgrabled():
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
	
	if option_size == 0:
		return
	
	show()
	get_tree().paused = true
