extends Node2D

var game_state := GameState.new()
var in_battle: bool = false
var paused: bool = false

@onready
var pause_panel = $root/pause_panel
@onready
var inventory_panel = $root/inventory_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	# pause panel
	pause_panel.after_popup.connect(func(_goal):
		paused = true
		$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.grab_focus())
	pause_panel.after_collapse.connect(func(_goal):
		paused = false)

	# inventory panel
	inventory_panel.after_popup.connect(func(_goal):
		$root/inventory_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/inventory_filter_button.grab_focus())
	inventory_panel.after_collapse.connect(func(_goal):
		$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.grab_focus())

	# pause > inventory button
	$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.pressed.connect(func():
		inventory_panel.popup())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# pause
	if not in_battle && Input.is_action_just_released("pause"):
		if paused && no_panel_other_than_pause_is_open():
			pause_panel.collapse()
		elif not paused:
			pause_panel.popup()
	# pause (2)
	if paused && Input.is_action_just_released("ui_cancel"):
		if inventory_panel.is_open:
			inventory_panel.collapse()
		elif pause_panel.is_open:
			pause_panel.collapse()

func no_panel_other_than_pause_is_open() -> bool:
	return inventory_panel.is_collapsed
