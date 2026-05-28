# Items are saved to items.json as an array of resource paths,
# then reloaded and converted back into ItemData resources.
# This script must be added as an AutoLoad.

extends Node

var items: Array[ItemData] = []
signal inventory_changed
const ITEMS_PATH := "user://items.json"

func _ready() -> void:
	load_items()

func get_items() -> Array[ItemData]:
	return items

func add_item(item: ItemData) -> void:
	if item == null:
		return

	items.append(item)
	save_items()
	inventory_changed.emit()

func remove_item(index: int) -> void:
	if index >= 0 and index < items.size():
		items.remove_at(index)
		save_items()
		inventory_changed.emit()

func save_items() -> void:
	var data: Array = []
	for item in items:
		if item == null:
			continue
		data.append(item.resource_path)

	var file = FileAccess.open(ITEMS_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(data, "\t"))

func load_items() -> void:
	if not FileAccess.file_exists(ITEMS_PATH):
		return

	var file = FileAccess.open(ITEMS_PATH, FileAccess.READ)
	if file == null:
		return
	var result = JSON.parse_string(file.get_as_text())

	if typeof(result) != TYPE_ARRAY:
		return

	items.clear()

	for path in result:
		if typeof(path) != TYPE_STRING:
			continue
		var item: ItemData = load(path)

		if item != null:
			items.append(item)

	inventory_changed.emit()