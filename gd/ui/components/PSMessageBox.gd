extends BaseAnimatedPanel

signal after_read

@onready
var _rtl = $PanelContainer/MarginContainer/VBoxContainer/message
var _typing: bool = false
var _typing_remaining := PackedStringArray()
var _typing_frame_max: int = 2
var _typing_frame_counter: int = 0

func type_message(msg: String):
	_rtl.text = ""
	if msg == "":
		_typing = false
		return
	_typing = true
	_typing_remaining = msg.split("")
	_typing_frame_counter = 0

func _process(delta):
	super._process(delta)
	if _typing:
		if Input.is_action_just_released("skip"):
			_typing = false
			_rtl.text += ArrayJoin.join(_typing_remaining, "")
			_typing_remaining = PackedStringArray()
		else:
			if _typing_frame_counter == 0:
				if _typing_remaining.size() == 0:
					_typing = false
				else:
					_rtl.text += ArrayShift.shift(_typing_remaining)
			_typing_frame_counter += 1
			_typing_frame_counter %= _typing_frame_max
	elif Input.is_action_just_released("skip") && is_open && (not _typing):
		after_read.emit()
