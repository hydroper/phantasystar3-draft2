class_name InventoryItem extends Object

var name: String = "undefined"
var description: Array[String] = ["No description available."]
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
	func _init(qty: int = 1):
		name = "Monomate"
		accumulates = true
		category = Category.CONSUMABLE
		quantity = qty

class Dimate extends InventoryItem:
	func _init(qty: int = 1):
		name = "Dimate"
		accumulates = true
		category = Category.CONSUMABLE
		quantity = qty
