class_name ClearNodeChildren extends Object

static func clear(node: Node) -> void:
	for c in node.get_children():
		node.remove_child(c)
