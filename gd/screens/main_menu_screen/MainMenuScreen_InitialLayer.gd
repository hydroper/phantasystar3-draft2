class_name MainMenuScreen_InitialLayer
extends LayerSetItem

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
