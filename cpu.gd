extends StaticBody

# Get a reference to the Ball
# Use this for the CPU to track the ball's position
onready var ball = $"../Ball"

# Max speed the CPU can travel. Measured in units per second
var speed := 40.0


func _ready() -> void:
	Game.connect("set_cpu_speed", self, "_on_set_cpu_speed")


func _process(delta) -> void:
	# Move the CPU toward the ball :P
	translation.z = move_toward(translation.z, ball.translation.z, speed * delta)
	translation.y = move_toward(translation.y, ball.translation.y, speed * delta)
	
	
func _on_set_cpu_speed(value: float) -> void:
	speed = value
