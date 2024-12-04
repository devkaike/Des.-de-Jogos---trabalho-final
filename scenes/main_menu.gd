extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_upgrades_pressed() -> void:
	skill_tree()
	
	
func menu():
	$Menu.show()
	$SkillTree.hide()
	#$Gold.hide()
	$Back.hide()
	
func skill_tree():
	$SkillTree.show()
	$Menu.hide()
	#$Gold.show()
	$Back.show()


func _on_back_pressed() -> void:
	menu()
