class_name GameState extends Object

# Dictionary[String, GameCharacter]
var characters := GameCharacter.all()

var party_members: Array[GameCharacter] = []

# Dictionary[GameCharacter, PartyMemberStatus]
var party_member_status: Dictionary = {}

var inventory_items: Array[InventoryItem] = []
