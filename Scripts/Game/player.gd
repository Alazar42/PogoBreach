extends Area3D

@onready var animation_player: AnimationPlayer = $Pepe_Skin_With_Animation/AnimationPlayer

func _ready():
	animation_player.play("mixamo_com")

func hit():
	if Globals.health > 0:
		Globals.health -= Globals.hit_value
		if Globals.health <= 0:
			Globals.health = 0
			print("Player defeated!")
