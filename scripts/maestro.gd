extends Node

@onready var main: Control = $main
@onready var farm: Control = $farm

func _on_farm_pressed() -> void:
	main.visible = false
	farm.visible = true

func _on_shop_pressed() -> void:
	farm.visible = false
	main.visible = true
