class_name ClearChildren extends Object

static func of(node: Node) -> void:
	for c in node.get_children():
		node.remove_child(c)
