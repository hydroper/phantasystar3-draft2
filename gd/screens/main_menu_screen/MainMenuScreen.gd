extends Node2D

var layer_set := LayerSet.new()
var initial_layer := MainMenuScreen_InitialLayer.new()
var game_selection_layer := MainMenuScreen_GameSelectionLayer.new()

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
