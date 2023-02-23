extends BaseAnimatedPanel

var _after_read_callback = null
var _was_read: bool = false

@onready
var _rtl = $PanelContainer/MarginContainer/VBoxContainer/message
var _typing: bool = false
var _typing_remaining := PackedStringArray()
var _typing_frame_max: int = 2
var _typing_frame_counter: int = 0
var _can_skip_typing: bool = false

var is_typing: bool:
	get:
		return _typing

var is_read: bool:
	get:
		return _was_read

func type_message(msg: String, after_read_callback: Callable = func(): pass):
	_after_read_callback = after_read_callback
	_rtl.text = ""
	_was_read = false
	if msg == "":
		_typing = false
		return
	_typing = true
	_typing_remaining = msg.split("")
	_typing_frame_counter = 0
	_can_skip_typing = false

func _process(delta):
	super._process(delta)
	if _typing:
		if _can_skip_typing && Input.is_action_just_released("done_reading_message"):
			_typing = false
			_rtl.text += ArrayJoin.join(_typing_remaining, "")
			_typing_remaining = PackedStringArray()
		else:
			if _typing_frame_counter == 0:
				if _typing_remaining.size() == 0:
					_typing = false
				else:
					_rtl.text += ArrayShift.shift(_typing_remaining)
			elif _typing_remaining.size() == 0:
				_typing = false
			_typing_frame_counter += 1
			_typing_frame_counter %= _typing_frame_max
			_can_skip_typing = true
	elif is_open && (not _typing) && Input.is_action_just_released("done_reading_message"):
		_was_read = true
		if _after_read_callback != null:
			_after_read_callback.call()
			_after_read_callback = null
