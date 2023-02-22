class_name GameCharacter extends Object

static func all() -> Dictionary:
	return {
		"rhys": Rhys.new(),
	}

var reference_id: String = "undefined"
var name: String = "undefined"

class Rhys extends GameCharacter:
	func _init():
		reference_id = "rhys"
		name = "Rhys"
