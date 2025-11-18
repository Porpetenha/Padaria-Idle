extends Node

var money: int
var bread_click: int = 1

@export var paes_data: Array[UpgradeData] = []  #Arrastar os .tres dos pães aqui
@export var upgrades_data: Array[UpgradeData] = []  #Arrastar os .tres dos bonus aqui

func time():
	var sec_offline = int(Time.get_unix_time_from_system() - SaveAndLoad.save_time)
	print("Ficou offline por ", sec_offline, " segundos")
	
	var hour = sec_offline / 3600
	var minutes = (sec_offline % 3600) /60
	
	print("Isso são ", hour, " horas e ", minutes, " minutos")
