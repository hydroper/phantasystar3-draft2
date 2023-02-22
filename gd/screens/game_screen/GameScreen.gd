extends Node2D

var game_state := GameState.new()
var in_battle: bool = false
var paused: bool = false

@onready
var pause_panel = $root/pause_panel
@onready
var inventory_panel = $root/inventory_panel
@onready
var leave_game_panel = $root/leave_panel

# collapse-priority-based Array of panels
var pause_related_panels = []
var pause_related_panels_but_no_root_panel = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_related_panels = [
		inventory_panel,
		leave_game_panel,
		pause_panel,
	]
	pause_related_panels_but_no_root_panel = pause_related_panels.filter(func(p):
		return p != pause_panel)
	# pause panel
	pause_panel.after_popup.connect(func(_goal):
		paused = true
		$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.grab_focus())
	pause_panel.after_collapse.connect(func(goal):
		if goal == "leave_game":
			get_tree().change_scene_to_file("res://gd/screens/main_menu_screen/MainMenuScreen.tscn")
		else:
			paused = false)

	# inventory panel
	inventory_panel.after_popup.connect(func(_goal):
		$root/inventory_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/inventory_filter_button.grab_focus()
		$root/inventory_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/inventory_filter_button.selected = 0)
	inventory_panel.after_collapse.connect(func(_goal):
		$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.grab_focus())
		
	# leave game panel
	leave_game_panel.after_popup.connect(func(_goal):
		$root/leave_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/no_button.grab_focus())
	leave_game_panel.after_collapse.connect(func(goal):
		if goal == "leave_game":
			pause_panel.collapse("leave_game")
		else:
			$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/leave_game_button.grab_focus())

	# pause > inventory button
	$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/inventory_button.pressed.connect(func():
		inventory_panel.popup())
	
	# pause > leave game button
	$root/pause_panel/PanelContainer/MarginContainer/VBoxContainer/leave_game_button.pressed.connect(func():
		leave_game_panel.popup())
	
	# leave game > yes button
	$root/leave_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/yes_button.pressed.connect(func():
		leave_game_panel.collapse("leave_game"))
	# leave game > no button
	$root/leave_panel/PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/no_button.pressed.connect(func():
		leave_game_panel.collapse())

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
		for p in pause_related_panels:
			if p.is_open:
				p.collapse()
				break

func no_panel_other_than_pause_is_open() -> bool:
	return pause_related_panels_but_no_root_panel.filter(func(p): return p.is_open).size() == 0
