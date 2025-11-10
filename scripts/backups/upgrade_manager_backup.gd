extends Control

@export var upgrade_scene: PackedScene
@export var paes_data: Array[UpgradeData] = []  # Arraste os .tres dos pães aqui
@export var upgrades_data: Array[UpgradeData] = []  # Arraste os .tres dos upgrades aqui

@onready var paes_container = $TabContainer/Pães/MarginContainer/ScrollContainer/VBoxContainer
@onready var upgrades_container = $TabContainer/Pães/MarginContainer/ScrollContainer/VBoxContainer/Upgrades

var player_money: int = 0
var pao_instances: Array[Node] = []
var upgrade_instances: Array[Node] = []

func _ready() -> void:
	create_items()

func create_items() -> void:
	# Cria os pães
	for data in paes_data:
		var item = upgrade_scene.instantiate()
		paes_container.add_child(item)
		item.setup(data)
		item.upgrade_purchased.connect(_on_upgrade_purchased)
		pao_instances.append(item)
	
	# Cria os upgrades
	for data in upgrades_data:
		var item = upgrade_scene.instantiate()
		upgrades_container.add_child(item)
		item.setup(data)
		item.upgrade_purchased.connect(_on_upgrade_purchased)
		upgrade_instances.append(item)
	
	update_affordability()

func _on_upgrade_purchased(upgrade_data: UpgradeData, level: int) -> void:
	var cost = upgrade_data.base_cost * pow(upgrade_data.cost_multp, level)
	
	if player_money >= cost:
		player_money -= cost
		
		# Aplica o bônus baseado no tipo
		match upgrade_data.upgrade_type:
			UpgradeData.upgrade_type_list.BREAD:
				# Aumenta produção de pão específico
				apply_bread_bonus(upgrade_data)
			UpgradeData.upgrade_type_list.CLICK_UPGRADE:
				# Aumenta ganho por clique
				apply_click_bonus(upgrade_data)
			UpgradeData.upgrade_type_list.IDLE_UPGRADE:
				# Aumenta ganho passivo
				apply_idle_bonus(upgrade_data)
		
		update_affordability()

func apply_bread_bonus(data: UpgradeData) -> void:
	# Lógica para aumentar produção de pão
	pass

func apply_click_bonus(data: UpgradeData) -> void:
	# Lógica para aumentar cliques
	pass

func apply_idle_bonus(data: UpgradeData) -> void:
	# Lógica para aumentar produção passiva
	pass

func update_affordability() -> void:
	for item in pao_instances + upgrade_instances:
		var can_afford = player_money >= item.current_cost
		item.set_affordable(can_afford)

func add_money(amount: int) -> void:
	player_money += amount
	update_affordability()
