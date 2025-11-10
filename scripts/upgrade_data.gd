class_name UpgradeData
extends Resource

enum upgrade_type_list {
	BREAD,     
	CLICK_UPGRADE, 
	IDLE_UPGRADE  
}

@export var name: String = "Nome do Upgrade"
@export var description: String = "Uma descrição para o upgrade"

@export_group("Dados do Jogo")

@export var upgrade_type: upgrade_type_list = upgrade_type_list.BREAD

@export_subgroup("Custo")
@export var base_cost: int = 10
@export var cost_multp: float = 1.2

@export_subgroup("Bonus")
@export var bonus_value: float = 1.0
var level:int = 0
@export_group("Visual")
@export var icon: Texture2D
@export var locked: bool = true


#Tipos de upgrade para eu fazer:

#Idle:
	#Aumenta a protuçao te tudo em x%
#Click:
	#Jackpot: uma pequena chance de um click dar uma grande ganho
#Produção:
	#Cada pão ou grupo de pão teria um aumento de % no que ele gera
