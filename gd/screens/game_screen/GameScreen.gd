extends Node2D

var game_state := GameState.new()
var in_battle: bool = false
var paused: bool = false

var pause_panel = null
var inventory_panel = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_panel = $root/pause_panel
	inventory_panel = $root/inventory_panel

	pause_panel.after_popup.connect(func(_goal):
		paused = true
		$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.grab_focus())
	pause_panel.after_collapse.connect(func(_goal):
		paused = false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# pause
	if not in_battle && Input.is_action_just_released("pause"):
		if paused && no_panel_other_than_pause_is_open():
			pause_panel.collapse()
		elif not paused:
			pause_panel.popup()

func no_panel_other_than_pause_is_open() -> bool:
	return inventory_panel.is_collapsed
