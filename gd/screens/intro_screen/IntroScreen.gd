extends Node2D

var animation_player: AnimationPlayer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# await get_tree().root.ready
	animation_player = $root/player
	animation_player.animation_finished.connect(func(_animation_name):
		skip_intro())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("skip"):
		if animation_player.current_animation_position < 1.3:
			animation_player.seek(1.3)
		else:
			skip_intro()

func skip_intro():
	get_tree().change_scene_to_file("res://gd/screens/main_menu_screen/MainMenuScreen.tscn")
