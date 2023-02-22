extends Node2D

var layer_set := LayerSet.new()
var initial_layer := InitialLayer.new()
var game_selection_layer := GameSelectionLayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	layer_set.items = [
		initial_layer,
		game_selection_layer,
	]
	initial_layer.canvas_layer = $root/initial_layer
	game_selection_layer.canvas_layer = $root/game_selection_layer
	layer_set.initialize()

	$root/start_animation_player.animation_finished.connect(func(animation_name):
		if animation_name == "default":
			layer_set.deferred_swap(initial_layer))

	# initial_layer
	$root/initial_layer/initial_panel/PanelContainer/MarginContainer/VBoxContainer/start_game_button.pressed.connect(func():
		layer_set.deferred_swap(game_selection_layer))
	$root/initial_layer/initial_panel/PanelContainer/MarginContainer/VBoxContainer/exit_button.pressed.connect(func():
		layer_set.deferred_swap(null, "exit"))

	# game_selection_layer
	$root/game_selection_layer/game_selection_panel/PanelContainer/MarginContainer/VBoxContainer/new_game_button.pressed.connect(func():
		$root/game_selection_layer/game_selection_panel.collapse("new_game"))
	$root/game_selection_layer/game_selection_panel/PanelContainer/MarginContainer/VBoxContainer/return_button.pressed.connect(func():
		layer_set.deferred_swap(initial_layer))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# initial_layer
	if layer_set.current_item == initial_layer:
		pass
	# game_selection_layer
	elif layer_set.current_item == game_selection_layer:
		if Input.is_action_just_released("ui_cancel"):
			layer_set.deferred_swap(initial_layer)

class InitialLayer extends LayerSetItem:
	var initial_panel = null
	var start_game_button = null

	func initialize():
		self.id = "initial_layer"
		initial_panel = self.get_child_node("root/initial_layer/initial_panel")
		start_game_button = self.get_child_node("root/initial_layer/initial_panel/PanelContainer/MarginContainer/VBoxContainer/start_game_button")
		initial_panel.after_popup.connect(func(goal):
			if goal == "initial":
				start_game_button.grab_focus())
		initial_panel.after_collapse.connect(func(goal):
			if goal == "game_selection":
				# switch to game_selection_layer
				immediate_swap(self.parent_set.item_by_id("game_selection_layer"))
			elif goal == "exit":
				self.canvas_layer.get_tree().quit())

	func show():
		initial_panel.popup("initial")

	func deferred_swap(swap_to: LayerSetItem, goal: String = ""):
		if goal == "exit":
			initial_panel.collapse("exit")
		elif swap_to == self.parent_set.item_by_id("game_selection_layer"):
			initial_panel.collapse("game_selection")

class GameSelectionLayer extends LayerSetItem:
	var game_selection_panel = null
	var game_selection_return_button = null

	func initialize():
		self.id = "game_selection_layer"
		game_selection_panel = self.get_child_node("root/game_selection_layer/game_selection_panel")
		game_selection_return_button = self.get_child_node("root/game_selection_layer/game_selection_panel/PanelContainer/MarginContainer/VBoxContainer/return_button")
		game_selection_panel.after_popup.connect(func(_goal):
			game_selection_return_button.grab_focus())
		game_selection_panel.after_collapse.connect(func(goal):
			if goal == "new_game":
				canvas_layer.get_tree().change_scene_to_file("res://gd/screens/game_screen/GameScreen.tscn")
			elif goal == "return":
				# switch to initial_layer
				immediate_swap(self.parent_set.item_by_id("initial_layer")))

	func show():
		game_selection_panel.popup("")

	func deferred_swap(swap_to: LayerSetItem, goal: String = ""):
		if swap_to == self.parent_set.item_by_id("initial_layer"):
			game_selection_panel.collapse("return")
