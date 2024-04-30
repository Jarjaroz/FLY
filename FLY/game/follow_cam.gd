extends Camera2D


@onready var player = $"../Player"


var screenWidth = 480
var screenHeight = 854
var distance: float
var divider: float

func _ready():
	SignalManager.on_timer_zero.connect(on_timer_zero)
func _process(delta):
	distance = (player.position.y-150) - position.y
	if distance < 150:
		divider = -0.003 * pow(distance,2) + 70
		position.y = position.y + (((player.position.y-150)-position.y)/divider*100)*delta
	#print("positionY:" + str(position.y) + ", PlayerV:" + str(player.velocity.y) + ", dis:" + str(distance))
 
func on_timer_zero():
	process_mode = Node.PROCESS_MODE_DISABLED
