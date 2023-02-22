extends BaseAnimatedPanel

signal after_read

@onready
var rtl = $PanelContainer/MarginContainer/VBoxContainer/message
var typing: bool = false
var typing_remaining := PackedStringArray()
var typing_frame_max: int = 2
var typing_frame_counter: int = 0

func type_message(msg: String):
	rtl.text = ""
	if msg == "":
		return
	typing = true
	typing_remaining = msg.split("")
	typing_frame_counter = 0

func _process(delta):
	super._process(delta)
	if typing:
		if typing_frame_counter == 0:
			if typing_remaining.size() == 0:
				typing = false
			else:
				var s = ArrayShift.shift(typing_remaining)
				if s == " " && typing_remaining.size() != 0:
					rtl.text += " " + ArrayShift.shift(typing_remaining)
				else:
					rtl.text += s
		typing_frame_counter += 1
		typing_frame_counter %= typing_frame_max
