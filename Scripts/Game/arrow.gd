extends Node3D

var velocity: Vector3
var target: Vector3
var toward_player: bool = false
var gravity: float

func _physics_process(delta: float) -> void:
	# Move arrow
	velocity.y += gravity * delta
	global_position += velocity * delta

	# Rotate arrow to match motion
	if velocity.length() > 0.01:
		look_at(global_position + velocity.normalized(), Vector3.UP)
