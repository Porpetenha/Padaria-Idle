class_name UpgradeData
extends Resource

enum upgrade_type_list {
	BREAD,     
	CLICK_UPGRADE, 
	IDLE_UPGRADE,
	BREAD_UPGRADE  
}

@export var name: String = "Nome do Upgrade"
@export var description: String = "Uma descrição para o upgrade"

@export_group("Dados do Jogo")

@export var upgrade_type: upgrade_type_list = upgrade_type_list.BREAD

@export_subgroup("Custo")
@export var base_cost: int = 0
@export var cost_multp: float = 0

@export_subgroup("Bonus")
@export var bonus_value: float = 0
var level:int = 0

@export_group("Visual")
@export var icon: Texture2D
@export var locked: bool = true


#Tipos de upgrade para eu fazer:

#Idle:
	#Aumenta a protuçao te tudo em x%
	#Ganhos afk, inicia com uma quantidade menor que 100% de ganho afk e vai aumentando conforme vai comprando mais upgrades dese tipo
#Click:
	#Jackpot: uma pequena chance de um click dar uma grande ganho
	#Uma porcentagem da produção total idle representa um incremento nos ganhos por click
#Pães:
	#Cada pão ou grupo de pão teria um aumento de % no que ele gera
	#
