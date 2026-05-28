# Attach this to any object that should be interactable by the player.
# This script acts as a bridge between the player and the object itself.

extends Area2D

@export var interact_name: String = ""
@export var is_interactable: bool = true

var interact: Callable = func():
	pass