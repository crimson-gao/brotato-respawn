extends "res://main.gd"

var _respawn_menu
var _respawn_timer: Timer


func _ready():
	ModLoaderLog.info("main ready", "Respawn")
	_respawn_menu = preload("res://mods-unpacked/Crimson-Respawn/extensions/respawn.tscn").instance()
	$UI.add_child(_respawn_menu)
	_respawn_timer = _respawn_menu.get_node("%Timer")
	_respawn_timer.connect("timeout", self, "_on_respawn_timer_timeout")
	_respawn_menu.hide()
	_respawn_menu.respawn_timer = _respawn_timer
	
	_respawn_menu.connect("confirm_respawn_button_pressed", self, "_on_confirm_respawn")
	_respawn_menu.connect("cancel_respawn_button_pressed", self, "_on_cancel_respawn")
	_respawn_menu.connect("respawn_cancel_by_input", self, "_on_respawn_cancel_by_input")
	
	_player.connect("player_take_mortal_damage", self, "_on_player_take_mortal_damage")
	
		
func _on_player_take_mortal_damage()->void :
	pause_before_choose_respawn()
	ModLoaderLog.info("player took mortal damage", "Respawn")
	if not _respawn_menu.visible:
		_respawn_menu.show()
		_respawn_menu.reset()
		_respawn_timer.start(10)


func _on_respawn_timer_timeout():
	ModLoaderLog.info("respawn timeout", "Respawn")
	_on_cancel_respawn()
	

func _on_confirm_respawn():
	if _respawn_menu.visible:
		_respawn_menu.hide()
		_respawn_timer.stop()
	ModLoaderLog.info("confirm respawn", "Respawn")
	_player.confirm_respawn()
	unpause_after_choose_respawn()

func _on_cancel_respawn():
	if _respawn_menu.visible:
		_respawn_menu.hide()
		_respawn_timer.stop()
	ModLoaderLog.info("cancel respawn", "Respawn")
	unpause_after_choose_respawn()
	_player.cancel_respawn()
	
func _on_respawn_cancel_by_input():
	ModLoaderLog.info("respawn cancel by input", "Respawn")
	_on_cancel_respawn()
	

func pause_before_choose_respawn():
	emit_signal("paused")
	ProgressData.update_mouse_cursor(true)
	get_tree().paused = true

func unpause_after_choose_respawn():
	ProgressData.update_mouse_cursor()
	get_tree().paused = false
	emit_signal("unpaused")
