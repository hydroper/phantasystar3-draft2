class_name LastChild extends Object

static func of(node: Node) -> Node:
	var r = node.get_children()
	return null if r.size() == 0 else r[r.size() - 1]
