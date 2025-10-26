extends Node3D

@onready var camera_3d: Camera3D = $Camera3D
@onready var player: Node3D = $Player
@onready var score_label: Label = $HUD/HUD/TextureRect2/ScoreLabel
@onready var health_bar: ProgressBar = $HUD/HUD/HealthBar

@export var correct_arrow_radius: float = 8.0
@export var correct_arrow_depth: float = -14.0
@export var correct_arrow_min_angle: float = 0.4
@export var correct_arrow_min_y_offset: float = 2.0

var arrow_scene := preload("res://Scenes/Game/arrow.tscn")

# Projectile physics
@export var projectile_speed: float = 20.0
@export var gravity: float = -25.0

# Track active arrows
var active_arrows := []

func _ready() -> void:
	score_label.text = str(Globals.health)
	health_bar.value = Globals.health

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and event.is_pressed():
		# Correct arrow (miss)
		print("Correct")
		var target = get_random_target()
		fire_arrow(target, false)
		
	elif event.is_action_pressed("ui_up") and event.is_pressed():
		# Wrong arrow (hit)
		if Globals.health > 0:
			Globals.health -= Globals.hit_value
			if Globals.health <= 0:
				Globals.health = 0
				print("Player defeated!")
			else:
				print("Wrong! Health:", Globals.health)
			
			# Update HUD
			score_label.text = str(Globals.health)
			health_bar.value = Globals.health

		var wrong_target = get_wrong_target()
		fire_arrow(wrong_target, true)

func get_random_target() -> Vector3:
	var angle = randf_range(correct_arrow_min_angle, TAU - correct_arrow_min_angle)
	var offset_x = cos(angle) * randf_range(correct_arrow_radius * 0.7, correct_arrow_radius)
	var offset_z = sin(angle) * randf_range(correct_arrow_radius * 0.7, correct_arrow_radius)
	var offset_y := 0.0
	while abs(offset_y) < correct_arrow_min_y_offset:
		offset_y = randf_range(-3.0, 3.0)
	return camera_3d.global_position + Vector3(offset_x, offset_y, correct_arrow_depth + offset_z)

func get_wrong_target() -> Vector3:
	var target_y_offset = randf_range(-1.0, -0.5)
	var target_x_offset = randf_range(-0.3, 0.3)
	var target_z_offset = randf_range(-0.3, 0.3)
	return player.global_position + Vector3(target_x_offset, target_y_offset, target_z_offset)

func fire_arrow(target_pos: Vector3, toward_player: bool) -> void:
	var arrow = arrow_scene.instantiate()
	add_child(arrow)
	
	arrow.global_position = camera_3d.global_position
	
	# Calculate projectile motion
	var start = arrow.global_position
	var displacement = target_pos - start
	var horizontal_displacement = Vector3(displacement.x, 0, displacement.z)
	var distance = horizontal_displacement.length()
	var time = distance / projectile_speed
	
	var velocity = horizontal_displacement.normalized() * projectile_speed
	velocity.y = (displacement.y + 0.5 * abs(gravity) * time) / time
	
	arrow.look_at(start + velocity, Vector3.UP)
	
	# Setup arrow physics
	arrow.set_physics_process(true)
	arrow.set("velocity", velocity)
	arrow.set("target", target_pos)
	arrow.set("toward_player", toward_player)
	arrow.set("gravity", gravity)
	arrow.set_script(preload("res://Scripts/Game/arrow.gd"))
	
	# Track arrow in Game.gd
	active_arrows.append(arrow)

func _physics_process(delta: float) -> void:
	# Update arrows and check for impact
	for arrow in active_arrows.duplicate():
		# Move arrow manually
		var velocity = arrow.get("velocity")
		velocity.y += arrow.get("gravity") * delta
		arrow.global_position += velocity * delta
		arrow.look_at(arrow.global_position + velocity, Vector3.UP)
		arrow.set("velocity", velocity)
		
		# Check for impact
		if arrow.global_position.distance_to(arrow.get("target")) < 0.5:
			if arrow.get("toward_player"):
				# Player got hit
				player.hit()
			arrow.queue_free()
			active_arrows.erase(arrow)

func _on_start_game_btn_pressed() -> void:
	pass

func _on_exit_btn_pressed() -> void:
	get_tree().quit(0)
