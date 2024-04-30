extends Node



var player_position: Vector2
var flowers_hit: int = 0

func _ready():
	SignalManager.on_flower_hit.connect(flower_hit)
	
func set_var_player_position(veckie: Vector2) -> void:
	player_position = veckie

func get_var_player_position() -> Vector2:
	return player_position

func flower_hit():
	flowers_hit += 1

func calculate_flower_boost():
	var return_value: int
	if 45 - flowers_hit*3 < 20:
		return_value = 20
	else:
		return_value = 50 -flowers_hit*2
	return return_value
