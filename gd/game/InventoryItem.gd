class_name InventoryItem extends Object

var name: String = "undefined"
var quantity: int = 1
var accumulates: bool = false
var disposable: bool = true
var category: Category = Category.OTHER

enum Category {
	CONSUMABLE,
	WEAPON,
	ARMOR,
	OTHER,
}

class Monomate extends InventoryItem:
	func _init():
		name = "Monomate"
		accumulates = true
		category = Category.CONSUMABLE

class Dimate extends InventoryItem:
	func _init():
		name = "Dimate"
		accumulates = true
		category = Category.CONSUMABLE
