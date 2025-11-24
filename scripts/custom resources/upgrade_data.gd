class_name UpgradeData
extends Resource

enum upgrade_type_list {
	BREAD,           # Pão base que gera dinheiro
	CLICK_UPGRADE,   # Melhora clicks
	IDLE_UPGRADE,    # Melhora produção idle geral
	BREAD_UPGRADE    # Melhora pães específicos ou grupos
}

enum bread_group {
	TERRA,
	INFERNO,
	CEUS,
	ABISMO,
	# Adicione mais dimensões aqui
}

@export var name: String = "Nome do Upgrade"
@export var description: String = "Uma descrição para o upgrade"

@export_group("Dados do Jogo")
@export var upgrade_type: upgrade_type_list = upgrade_type_list.BREAD

# Para pães: a qual grupo/dimensão pertence
@export var group: bread_group = bread_group.TERRA

@export_subgroup("Custo")
@export var base_cost: int = 10
@export var cost_multp: float = 1.15  # Multiplicador de custo (para futuro)

@export_subgroup("Bonus para pães")
@export var bonus_value: float = 1.0  # Produção base do pão
var level: int = 0

# Para upgrades de pães específicos
@export_subgroup("Upgrade de Pães")
@export var target_group: bread_group = bread_group.TERRA  # Qual grupo é afetado
@export var bonus_multiplier: float = 0.0  # Multiplicador em % (ex: 0.5 = +50%)
@export var is_percentage: bool = false  # Se true, aplica em %, se false, valor fixo

@export_group("Visual")
@export var icon: Texture2D
@export var locked: bool = true

# Calcula o custo atual baseado no nível
func get_current_cost() -> int:
	return int(base_cost * pow(cost_multp, level))
