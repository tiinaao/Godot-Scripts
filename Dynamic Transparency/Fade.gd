# Makes certain sprites (e.g. walls and doors) become transparent when the player enters
# a trigger area, and restores them when the player leaves.
# The door is excluded from fading while it is animating to avoid conflicts
# with its own animation state.


extends Area2D

@onready var walls: Sprite2D = $"../Sprite2D"
@onready var door_sprite: Sprite2D = $"../Door/Sprite2D"
@onready var door: StaticBody2D = $"../Door"

var sprites_to_fade: Array[Sprite2D]
@export var fade_time := 0.3
@export var target_alpha := 0.2

func _ready():
	sprites_to_fade = [walls, door_sprite]

func _on_body_entered(body: Node2D) -> void:
	if body.name == "MC":
		fade_all(target_alpha)

func _on_body_exited(body: Node2D) -> void:
	if body.name == "MC":
		fade_all(1.0)

func fade_all(alpha: float) -> void:
	for sprite in sprites_to_fade:
		if sprite == door_sprite and (door.is_open or door.is_animating):
			continue
		var tween = create_tween()
		tween.tween_property(sprite, "modulate:a", alpha, fade_time)
		tween.tween_callback(func(): sprite.position = sprite.position.snapped(Vector2(1, 1)))