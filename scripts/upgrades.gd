extends PanelContainer

@onready var icon: TextureRect = $MarginContainer/HBoxContainer/icon
@onready var name_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/name
@onready var level_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/level
@onready var buy_button: Button = $MarginContainer/HBoxContainer/buy

@onready var lock_panel: Panel = $lock

@onready var tooltip: PanelContainer = $CanvasLayer/tooltip
@onready var tooltip_desc: RichTextLabel = $CanvasLayer/tooltip/tooltip_desc

#Puxa a classe UpgradeData que é o resource para cirar os status do upgrades
var upgrade_data: UpgradeData

func _ready() -> void:
	pass

func setup(data: UpgradeData) -> void:
	upgrade_data = data
	
	# Configura visual
	icon.texture = data.icon
	name_label.text = data.name
	level_label.text = str(data.level)
	buy_button.text = str(data.base_cost)

	#Para bloquear o upgrade
	if data.locked == true:
		lock_panel.visible = true

	#Tooltip 
	tooltip.visible = false
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	tooltip.custom_minimum_size.x = 200

#Quando eu clicar no botão de compra do upgrade ele vai descontar o valor
func _on_buy_pressed() -> void:
	if Global.money >= upgrade_data.base_cost:
		upgrade_data.level += 1
		level_label.text = str(upgrade_data.level)
		print(upgrade_data.name + ": " + str(upgrade_data.level))
		Global.money -= upgrade_data.base_cost

func _on_mouse_entered() -> void:
	if upgrade_data:
		tooltip_desc.text = upgrade_data.name + "\n\n" + upgrade_data.description
		
		# Posicionar à esquerda (em coordenadas GLOBAIS)
		var pos = global_position
		pos.x -= tooltip.size.x + 10  # 10px de offset
		
		tooltip.global_position = pos
		tooltip.visible = true

func _on_mouse_exited() -> void:
	tooltip.visible = false
