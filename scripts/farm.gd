extends Control

@onready var money: RichTextLabel = $VBoxContainer/status_bar/HBoxContainer/money

func _process(delta: float) -> void:
	money.text = str(Global.money)
