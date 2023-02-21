class_name EnableRecursiveFocus
extends Object

static func enable(node: Node):
	node.propagate_call("set_disabled", [false])
	node.propagate_call("set_editable", [true])
	#if node is BaseButton:
	#	node.disabled = false
	#elif node is TextEdit:
	#	node.editable = true
	#for c in node.get_children():
	#	enable(c)

static func disable(node: Node):
	node.propagate_call("set_disabled", [true])
	node.propagate_call("set_editable", [false])
