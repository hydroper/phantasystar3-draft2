class_name LayerSetItem
extends Object

var id: String = ""
var parent_set: LayerSet = null
var canvas_layer: CanvasLayer = null

func initialize():
	pass

func get_child_node(path: NodePath) -> Node:
	return canvas_layer.get_tree().root.get_child(0).get_node(path)

func show():
	pass

func deferred_swap(swap_to: LayerSetItem, goal: String = ""):
	if parent_set.current_item == swap_to:
		return
	immediate_swap(swap_to)

func immediate_swap(swap_to: LayerSetItem):
	if parent_set.current_item == swap_to:
		return
	parent_set.immediate_swap(swap_to)
