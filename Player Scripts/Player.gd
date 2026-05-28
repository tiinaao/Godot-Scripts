extends CharacterBody2D

@export var speed := 150

@onready var animation_player = $AnimationPlayer
@onready var sprite = $"MCSheet"

func _physics_process(delta):
	var dir = Input.get_vector("left", "right", "up", "down")

	velocity = dir * speed
	move_and_slide()
	play_animation(dir)

func play_animation(dir: Vector2):
	if dir == Vector2.ZERO:
		animation_player.play("idle")
		return

	if abs(dir.x) > abs(dir.y):
		sprite.flip_h = dir.x < 0
		animation_player.play("walk r")
	else:
		if dir.y < 0:
			animation_player.play("walk b")
		else:
			animation_player.play("walk f")
