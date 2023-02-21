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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
