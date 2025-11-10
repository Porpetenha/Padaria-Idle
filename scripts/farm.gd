extends Control

@onready var money: RichTextLabel = $VBoxContainer/status_bar/HBoxContainer/money

func _process(delta: float) -> void:
	money.text = str(Global.money)
	
func _on_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
