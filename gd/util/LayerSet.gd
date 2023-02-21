class_name LayerSet
extends Object

var current_item: LayerSetItem = null
var items: Array[LayerSetItem] = []

func initialize() -> void:
	for sw in items:
		sw.parent_set = self
		sw.initialize()
	deferred_swap(null)

func deferred_swap(swap_to: LayerSetItem, goal: String = "") -> void:
	if swap_to != null && current_item == swap_to:
		return
	if current_item != null:
		current_item.deferred_swap(swap_to, goal)
	else:
		immediate_swap(swap_to)

func immediate_swap(swap_to: LayerSetItem) -> void:
	for sw in items:
		sw.canvas_layer.visible = false
	if swap_to == null:
		current_item = null
		return
	current_item = swap_to
	swap_to.canvas_layer.visible = true
	swap_to.show()

func item_by_id(id: String) -> LayerSetItem:
	# suggestion: functional filter()
	for it in items:
		if it.id == id:
			return it
	return null
