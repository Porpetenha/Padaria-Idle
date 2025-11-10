extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/HBoxContainer/icon
@onready var name_label: Label = $MarginContainer/HBoxContainer/name
@onready var buy_button: Button = $MarginContainer/HBoxContainer/buy

var upgrade_data: UpgradeData
var current_level: int = 0
var current_cost: int

signal upgrade_purchased(upgrade: UpgradeData, level: int)

func setup(data: UpgradeData) -> void:
	upgrade_data = data
	
	# Configura visual
	icon.texture = data.icon
	name_label.text = data.name
	
	# Calcula custo inicial
	update_cost()
	
	# Conecta o botão
	buy_button.pressed.connect(_on_buy_pressed)

func update_cost() -> void:
	current_cost = int(upgrade_data.base_cost * pow(upgrade_data.cost_multp, current_level))
	buy_button.text = str(current_cost)

func set_affordable(can_afford: bool) -> void:
	buy_button.disabled = !can_afford

func _on_buy_pressed() -> void:
	upgrade_purchased.emit(upgrade_data, current_level)
	current_level += 1
	update_cost()
