extends Node

const save: String = "user://save.json"

func save_data():
	#Criar dicionário com os níveis dos upgrades
	var upgrades_levels = {}
	for upgrade in Global.paes_data:
		upgrades_levels[upgrade.name] = upgrade.level
		
	var data = {
		"money" : Global.money,
		"upgrades" : upgrades_levels
	}
	
	var file = FileAccess.open(save, FileAccess.WRITE)
	
	if file == null:
		printerr("Não foi prossível abrir")
		return
		
	var json = JSON.stringify(data)
	file.store_string(json)
	file.close()

signal data_loaded

func load_data():
	if not FileAccess.file_exists(save):
		print("Save não existe, criando um novo...")
		save_data()  # Cria o save com os valores iniciais
		return
	
	var file = FileAccess.open(save, FileAccess.READ)
	
	if file == null:
		printerr("Não foi prossivel abrir")
		return
	
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(content)
	
	if error != OK:
		printerr("Não foi possível fazer a conversão do json")
		printerr("Erro: %s" % json.get_error_message())
		printerr("Na linha: %d" % json.get_error_line())
	
	var data = json.data
	
	Global.money = data.get("money", 0)
	
	if data.has("upgrades"):
		var upgrades_levels = data["upgrades"]
		for upgrade in Global.paes_data:
			if upgrades_levels.has(upgrade.name):
				upgrade.level = upgrades_levels[upgrade.name]

	data_loaded.emit()
