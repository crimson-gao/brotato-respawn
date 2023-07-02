extends Player

signal player_take_mortal_damage

var _player_waiting_respawn = false
var _saved_knockback_vector:Vector2
var _saved_p_cleaning_up:bool

func _ready():
	ModLoaderLog.info("player ready", "Respawn")
	
func take_damage(value:int, hitbox:Hitbox = null, dodgeable:bool = true, armor_applied:bool = true, custom_sound:Resource = null, base_effect_scale:float = 1.0, bypass_invincibility:bool = false)->Array:
	# prevent more damage, if choosing respawn
	if _player_waiting_respawn:
		return [0, 0, false]
	return .take_damage(value, hitbox, dodgeable, armor_applied,custom_sound, base_effect_scale)


# hook die, so that we can ask for respawn before player really die
func die(knockback_vector:Vector2 = Vector2.ZERO, p_cleaning_up:bool = false)->void :
	_player_waiting_respawn = true
	_saved_knockback_vector = knockback_vector
	_saved_p_cleaning_up = p_cleaning_up
	emit_signal("player_take_mortal_damage")
	

func set_hp_max():
	SoundManager.play(Utils.get_rand_element(hp_regen_sounds), get_heal_db(), 0.1)
	current_stats.health = max_stats.health
	emit_signal("health_updated", current_stats.health, max_stats.health)

func confirm_respawn():
	set_hp_max()
	_invincibility_timer.start(2)
	_player_waiting_respawn = false
	ModLoaderLog.info("do respawn", "Respawn")
	
	
func cancel_respawn():
	_player_waiting_respawn = false
	.die(_saved_knockback_vector, _saved_p_cleaning_up)
