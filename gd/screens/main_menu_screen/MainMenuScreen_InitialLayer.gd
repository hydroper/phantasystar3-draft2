class_name MainMenuScreen_InitialLayer
extends LayerSetItem

var initial_panel = null
var start_game_button = null
var deferred_swap_item: LayerSetItem = null

func initialize():
	initial_panel = self.canvas_layer.get_tree().root.get_child(0).get_node("root/initial_layer/initial_panel")
	start_game_button = self.canvas_layer.get_tree().root.get_child(0).get_node("root/initial_layer/initial_panel/PanelContainer/MarginContainer/VBoxContainer/start_game_button")
	initial_panel.after_popup.connect(func():
		start_game_button.grab_focus())
	initial_panel.after_collapse.connect(func():
		# switch to first_menu
		immediate_swap(deferred_swap_item))

func show():
	initial_panel.popup()

func deferred_swap(swap_to: LayerSetItem):
	deferred_swap_item = swap_to
	initial_panel.collapse()
