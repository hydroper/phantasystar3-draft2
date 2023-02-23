class_name BaseAnimatedPanel
extends Control

signal outer_click
signal after_popup(goal: String)
signal after_collapse(goal: String)

var _disabled: bool = false
var _popup_goal: String = ""
var _collapse_goal: String = ""
var _busy: bool = false
var _open_close_timer_max: float = 9
var _mult_factor: float = 1.0 / _open_close_timer_max
var _open_timer: float = 0
var _close_timer: float = 0
var _collapsed: bool = true

func _init():
	self.visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _close_timer > 0:
		self.position.x += self.size.x / 2 * _mult_factor
		self.scale.x = (_close_timer - 1) * _mult_factor
		if _close_timer == 1:
			self.visible = false
			self.position.x -= self.size.x / 2
			_busy = false
			_collapsed = true
			self.after_collapse.emit(_collapse_goal)
		_close_timer -= 1
	elif _open_timer > 0:
		self.position.x -= self.size.x / 2 * _mult_factor
		self.scale.x = 1 - (_open_timer - 1) * _mult_factor
		_open_timer -= 1
		if _open_timer == 0:
			disabled = false
			_busy = false
			_collapsed = false
			self.after_popup.emit(_popup_goal)

func _input(event):
	if is_open && !_busy && (event is InputEventMouseButton) and event.pressed:
		var ev_local = make_input_local(event)
		if !Rect2(Vector2(0, 0), size).has_point(ev_local.position):
			outer_click.emit()

func popup(goal: String = ""):
	if _busy:
		return
	_busy = true
	_popup_goal = goal
	self.visible = true
	disabled = true
	_open_timer = _open_close_timer_max
	self.position.x += self.size.x / 2

func collapse(goal: String = ""):
	if _busy:
		return
	# get_viewport().gui_release_focus()
	_collapse_goal = goal
	_busy = true
	_close_timer = _open_close_timer_max
	disabled = true

var disabled: bool:
	get:
		return _disabled
	set(value):
		_disabled = value
		if value:
			EnableRecursiveFocus.disable(self)
		else:
			EnableRecursiveFocus.enable(self)

var is_open: bool:
	get:
		return !_collapsed

var is_collapsed: bool:
	get:
		return _collapsed
