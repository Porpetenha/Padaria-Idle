extends TextureButton

const EMBER_PARTICLES = preload("res://assets/prefab/particle.tscn")
const POP_UP = preload("res://assets/prefab/click_pop_up.tscn")
@onready var sound: AudioStreamPlayer2D = $fire_sound

func _ready():
	#Define o pivô no centro do botão
	pivot_offset = size / 2
	#particles.position = size / 2
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
	#Chama a amimação quando clica no botão
	animation()
	
	#Cria novas partículas
	spawn_particles()
	
	#Pop up do ganho por click
	click_pop_up()
	
	#Reproduz o som do fogo
	#fire_sound()
	
func animation():
	var tween = create_tween()
	tween.set_parallel(true)
	
	# Pulsar (scale)
	tween.tween_property(self, "scale", Vector2(1.15, 1.15), 0.1)
	tween.chain().tween_property(self, "scale", Vector2(1.0, 1.0), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	
	# Chacoalhar (rotation)
	tween.tween_property(self, "rotation", deg_to_rad(-5), 0.1)
	tween.chain().tween_property(self, "rotation", deg_to_rad(5), 0.1)
	tween.chain().tween_property(self, "rotation", deg_to_rad(-3), 0.1)
	tween.chain().tween_property(self, "rotation", 0, 0.1)

func spawn_particles():
	var particles = EMBER_PARTICLES.instantiate()
	add_child(particles)
	particles.position = size / 2
	particles.emitting = true
	
	#Remove as partículas após terminarem
	get_tree().create_timer(particles.lifetime).timeout.connect(func(): particles.queue_free())

func click_pop_up():
	var popup = POP_UP.instantiate()
	add_child(popup)
	var label = popup.get_child(0)
	
	label.text = "+" + str(Global.bread_click)
	
	label.global_position = global_position + (size / 2) - (label.size / 2)
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(label, "position", Vector2(randf_range(100, 300), randf_range(200, 400)), 1)
	tween.tween_property(label, "scale", Vector2(2, 2), 1)
	
	get_tree().create_timer(1).timeout.connect(func(): popup.queue_free())

func fire_sound():
	sound.play()
