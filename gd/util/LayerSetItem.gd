class_name LayerSetItem

var parent_set: LayerSet = null
var canvas_layer: CanvasLayer = null

func initialize():
	pass

func show():
	pass

func deferred_swap(swap_to: LayerSetItem):
	if parent_set.current_item == swap_to:
		return
	immediate_swap(swap_to)

func immediate_swap(swap_to: LayerSetItem):
	if parent_set.current_item == swap_to:
		return
	parent_set.immediate_swap(swap_to)
