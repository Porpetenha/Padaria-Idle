extends Control

@export var upgrade_scene: PackedScene #Arrastar para carrega o prefab de molde
@export var paes_data: Array[UpgradeData] = []  #Arrastar os .tres dos pães aqui
@export var upgrades_data: Array[UpgradeData] = []  #Arrastar os .tres dos bonus aqui

@onready var paes_container = $TabContainer/Pães/MarginContainer/ScrollContainer/VBoxContainer
@onready var upgrades_container = $TabContainer/Upgrades/MarginContainer/ScrollContainer/VBoxContainer

var pao_instances: Array[Node] = []
var upgrade_instances: Array[Node] = []

func _ready() -> void:
	Global.paes_data = paes_data
	Global.upgrades_data = upgrades_data
	create_items()

func create_items() -> void:
	#Ordena os arrays pelo base_cost (do menor para o maior)
	paes_data.sort_custom(func(a, b): return a.base_cost < b.base_cost)
	upgrades_data.sort_custom(func(a, b): return a.base_cost < b.base_cost)
	
	#Cia os pães
	for data in paes_data:
		var item = upgrade_scene.instantiate()
		paes_container.add_child(item)
		item.setup(data)
		pao_instances.append(item)
	
	#Cria os upgrades de bonus
	for data in upgrades_data:
		var item = upgrade_scene.instantiate()
		upgrades_container.add_child(item)
		item.setup(data)
		upgrade_instances.append(item)
