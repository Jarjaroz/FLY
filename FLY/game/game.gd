extends Node2D


@export var pipes_scene1: PackedScene
@export var pipes_scene2: PackedScene

@onready var game_ui = $Canvas/gameUI

@onready var player = $Player
@onready var pipes_holder = $pipesHolder
@onready var spawn_left = $world_boundries2/SpawnLeft
@onready var spawn_right = $world_boundries2/SpawnRight

func _ready():
	SignalManager.on_spawn_new_pipe.connect(spawn_pipes)
	SignalManager.on_spawn_new_pipe.emit()
	


func spawn_pipes() -> void:
	print("spawning a new one -_-" + str(spawn_left.position.y))
	var x_pos = 240
	var new_pipes
	var flip: int = 1
	if 1 == randi_range(1,3):
		new_pipes = pipes_scene2.instantiate()
	else:
		x_pos = randf_range(spawn_left.position.x, spawn_right.position.x)
		new_pipes = pipes_scene1.instantiate()
	if 1 == randi_range(1,2):
			flip = 1
	else:
			flip = -1
	new_pipes.position = Vector2(x_pos, spawn_left.position.y)
	new_pipes.scale.x = new_pipes.scale.x * flip
	pipes_holder.add_child(new_pipes)

func stop_pipes() -> void:
	for pipes in pipes_holder.get_children():
		pipes.set_process(false)

func on_game_over():
	stop_pipes()
	game_ui.hide()
	
	

