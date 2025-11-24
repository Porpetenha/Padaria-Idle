extends Node

var money: float
var bread_click: float = 1

@export var paes_data: Array[UpgradeData] = []  #Arrastar os .tres dos pães aqui
@export var upgrades_data: Array[UpgradeData] = []  #Arrastar os .tres dos bonus aqui

func time():
	var sec_offline = int(Time.get_unix_time_from_system() - SaveAndLoad.save_time)
	print("Ficou offline por ", sec_offline, " segundos")
	
	var hour = sec_offline / 3600
	var minutes = (sec_offline % 3600) /60
	
	print("Isso são ", hour, " horas e ", minutes, " minutos")
	
# Formata números grandes de forma legível
func format_number(num: float) -> String:
	if num < 1000:
		return str(snapped(num, 0.01))
	elif num < 1000000:
		return str(snapped(num / 1_000.0, 0.01)) + "K"
	elif num < 1000000000:
		return str(snapped(num / 1_000_000.0, 0.01)) + "M"
	else:
		return str(snapped(num / 1_000_000_000.0, 0.01)) + "B"
	
