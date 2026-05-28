# This script assumes that the Camera2D is a child of the CharacterBody2D

extends Camera2D

@export var smooth_speed := 3.0
@onready var target := get_parent() as CharacterBody2D

func _ready():
	top_level = true
	global_position = target.global_position  

func _process(delta):
	global_position = global_position.lerp(target.global_position, 1.0 - exp(-smooth_speed * delta))
	global_position = (global_position * zoom).round() / zoom