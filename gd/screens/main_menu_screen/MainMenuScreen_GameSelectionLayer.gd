class_name MainMenuScreen_GameSelectionLayer
extends LayerSetItem

var game_selection_panel = null
var game_selection_return_button = null

func initialize():
	self.id = "game_selection_layer"
	game_selection_panel = self.get_child_node("root/game_selection_layer/game_selection_panel")
	game_selection_return_button = self.get_child_node("root/game_selection_layer/game_selection_panel/PanelContainer/MarginContainer/VBoxContainer/return_button")
	game_selection_panel.after_popup.connect(func(goal):
		game_selection_return_button.grab_focus())
	game_selection_panel.after_collapse.connect(func(goal):
		if goal == "return":
			# switch to initial_layer
			immediate_swap(self.parent_set.item_by_id("initial_layer")))

func show():
	game_selection_panel.popup("")

func deferred_swap(swap_to: LayerSetItem, goal: String = ""):
	if swap_to == self.parent_set.item_by_id("initial_layer"):
		game_selection_panel.collapse("return")
