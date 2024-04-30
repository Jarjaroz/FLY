extends CharacterBody2D

const GRAVITY: float = 2000.0
const POWER: float = 7000.0
const TURN_POWER: float = 25
const RECENTER_POWER: float = 0.5
const SLOW_DOWN_POWER: float = 3
const SLOW_DOWN_DEGREES: float = 15
const TURN_TIME: float = 15

var turn_counter: int = 0
var turn_direction: int = 0 
var current_power: float = 0
var is_death: bool = false

func _ready():
	SignalManager.on_timer_zero.connect(on_timer_zero)

func _physics_process(delta):
	if(!is_death):
		key_detect()
		turn(delta)
		recenter()
	slow_down()
	apply_gravity(delta)
	GameManager.set_var_player_position(position)
	move_and_slide()

func turn(delta: float) -> void:
	turn_counter += 1
	if(TURN_TIME <= turn_counter || turn_direction == 0):
		turn_direction = 0
		return
	rotation_degrees += TURN_POWER/TURN_TIME * turn_direction
	current_power = -4 * turn_counter * turn_counter * turn_counter + POWER
	if velocity.y > -500:
		velocity += Vector2(current_power * delta * cos(deg_to_rad(rotation_degrees-90))
				,current_power * delta * sin(deg_to_rad(rotation_degrees-90)))
	else:
		velocity += Vector2(0.5 * current_power * delta * cos(deg_to_rad(rotation_degrees-90))
				,0.5 *current_power * delta * sin(deg_to_rad(rotation_degrees-90)))

func slow_down() -> void:
	if velocity.x == 0:
		return
	if is_on_floor() and abs(rotation_degrees) < SLOW_DOWN_DEGREES:
		velocity.x =0

func recenter() -> void:
	if(abs(rotation_degrees) < 2):
		return
	if(rotation_degrees > 0):
		if is_on_floor():
			rotation_degrees -= RECENTER_POWER*5
		else:
			if turn_counter < 0.60*TURN_TIME:
				rotation_degrees -= 0.6*RECENTER_POWER
			else:
				rotation_degrees -= RECENTER_POWER
	else:
		if is_on_floor():
			rotation_degrees += RECENTER_POWER*5
		else:
			if turn_counter < 0.60*TURN_TIME:
				rotation_degrees += 0.6*RECENTER_POWER
			else:
				rotation_degrees += RECENTER_POWER

func key_detect() -> void:
	if Input.is_action_just_pressed("left") == true:
		turn_direction = -1
		turn_counter = 0
		
		
	if Input.is_action_just_pressed("right") == true:
		turn_direction = 1
		turn_counter = 0
		

func apply_gravity(delta: float) -> void:
	if velocity.y < 500:
		velocity.y += GRAVITY*delta
	else:
		velocity.y += 0.60 * GRAVITY*delta

func on_timer_zero() -> void:
	print("erroring death")
	is_death = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass
