extends TextureButton

const EMBER_PARTICLES = preload("res://assets/prefab/particle.tscn")

func _ready():
	# Define o pivô no centro do botão
	pivot_offset = size / 2
	#particles.position = size / 2
	pressed.connect(_on_button_pressed)

func _on_button_pressed():
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
	
	# Cria novas partículas
	spawn_particles()

func spawn_particles():
	var particles = EMBER_PARTICLES.instantiate()
	add_child(particles)
	particles.position = size / 2
	particles.emitting = true
	
	# Remove as partículas após terminarem
	get_tree().create_timer(particles.lifetime).timeout.connect(
		func(): particles.queue_free()
	)
