extends BaseAnimatedPanel

func type_message(msg: String):
	pass

func _ready():
	super._ready()
	$PanelContainer/MarginContainer/VBoxContainer/message.text = ""

func _process(delta):
	super._process(delta)
