# A simple interactable loot box.
# Requires:
# - A child Area2D called "Interactable" that triggers interaction
# - A Sprite2D with two frames:
#   frame 0 = closed box
#   frame 1 = opened box
#
# When interacted with for the first time, the box:
# - switches to the open sprite
# - disables further interaction
# - optionally gives an item from ItemData


extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var item: ItemData
var item_given := false
var used := false

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	if used:
		return
	used = true
	sprite_2d.frame = 1
	interactable.is_interactable = false
	if item != null and not item_given:
		Itemdb.add_item(item)
		item_given = true
