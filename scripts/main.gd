extends Control

@onready var money_label: RichTextLabel = $VBoxContainer/status_bar/HBoxContainer/money
@onready var click_forno: TextureButton = $VBoxContainer/margin/HBoxContainer/forno/VBoxContainer/click_forno
@onready var bread_production: Label = $VBoxContainer/MarginContainer/HBoxContainer/forno/VBoxContainer/bread_production

#Váriaveis
var bread_click: float = 0
var bread_idle: float = 0
var idle_timer : Timer

func _ready():
	SaveAndLoad.load_data()
	
	bread_click = bread_click
	
	#Set timer para gerar idle
	idle_timer = Timer.new()
	idle_timer.wait_time = 1.0  # 1 seg
	idle_timer.autostart = true
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(idle_timer)
	
func _process(_delta: float) -> void:
	#Set do calculo para a produção
	production_calc() 
	
	#Set da label para o dinheiro e para a produção
	money_label.text = str(Global.money)
	bread_production.text = "Produção: \n" + str(bread_click) + " /click \n" + str(bread_idle) + " /sec" 
	
	#Qando clicar no botão do forno vai produzir dinherio por click
func _on_click_forno_pressed() -> void:
	Global.money += int(bread_click)

	#Função para a geração idle de dinheiro
func _on_idle_timer_timeout() -> void:
	Global.money += int(bread_idle)
 
func production_calc():
	bread_click = 1
	bread_idle = 0
	
	# Agora você tem acesso direto!
	for pao in Global.paes_data:
		if pao.upgrade_type == UpgradeData.upgrade_type_list.BREAD:
			bread_idle += int(pao.bonus_value) * pao.level

func _on_button_pressed() -> void:
	pass
	SaveAndLoad.save_data()
	
