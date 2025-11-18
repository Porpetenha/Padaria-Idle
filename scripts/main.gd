extends Control

@onready var money_label: RichTextLabel = $VBoxContainer/status_bar/HBoxContainer/money
@onready var click_forno: TextureButton = $VBoxContainer/margin/HBoxContainer/forno/VBoxContainer/click_forno
@onready var bread_production: Label = $VBoxContainer/MarginContainer/HBoxContainer/forno/VBoxContainer/bread_production

#Váriaveis
var bread_click: = Global.bread_click
var bread_idle: int 

func _ready():
	SaveAndLoad.load_data()
	timer(1)
	Global.time()
	

func _process(_delta: float) -> void:
	production_calc() 
	set_label()


func timer(time): #OK
	var idle_timer : Timer
	idle_timer = Timer.new()
	idle_timer.wait_time = time
	idle_timer.autostart = true
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(idle_timer)


func set_label(): #OK
	money_label.text = str(Global.money)
	bread_production.text = "Produção: \n" + str(bread_click) + " /click \n" + str(bread_idle) + " /sec" 

func _on_click_forno_pressed() -> void: #OK
	Global.money += int(bread_click) #Qando clicar no botão do forno vai produzir dinherio por click

func _on_idle_timer_timeout() -> void:
	Global.money += int(bread_idle) #Função para a geração idle de dinheiro

func production_calc():
	bread_idle = 0
	# Agora você tem acesso direto!
	for pao in Global.paes_data:
		if pao.upgrade_type == UpgradeData.upgrade_type_list.BREAD:
			bread_idle += int(pao.bonus_value) * pao.level
			


func _on_button_pressed() -> void:
	pass
	SaveAndLoad.save_data()
	
