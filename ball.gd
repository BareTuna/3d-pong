extends KinematicBody

# I usually use class_name for nice looking checks
# i.e `if node is Ball:`
class_name Ball

# However, class_name is a little buggy in this version of GDScript
# The workaround is to override get_class and return "Ball"
# i.e. `if node.get_class() == "Ball":`
func get_class(): return "Ball"


# When the ball collides with something, emit a signal
signal hit(collider, sender)


# Velocity mostly dictates the direction the ball is moving
export var velocity := Vector3()

# Speed simply dictates how fast the ball is moving
export var speed := 30.0 setget set_speed
# Use a setter to make sure the velocity and speed are the same
func set_speed(value : float):
	speed = value
	velocity = velocity.normalized() * speed
# Store the default speed to make it go slow when someone gets a point
onready var default_speed := speed


# Captured means it touched an Area (someone scored a point)
# I use it to create the ball slowing down effect
var captured := false
# Slowdown multiplies the velocity by the number below every frame
# i.e. 0 slows down immediately, 1 doesn't slow down at all
const SLOWDOWN := 0.95


func _ready() -> void:
	set_speed(speed) # Needed here, or else speed doesn't get set the first time


func _physics_process(delta) -> void:
	# If the ball is out of bounds, apply the slow down effect 
	if captured:
		velocity_slowdown()
	
	# Collision detection
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		set_speed(speed + 1) # Increase speed
		emit_signal("hit", collision.collider, self)


func velocity_slowdown():
	velocity *= SLOWDOWN
	
	# Arbitrary limit 0.03
	# Too low and the ball will appear stopped
	# Too high and it hardly any slowdown will happen to the ball
	if velocity.length_squared() < 0.03:
		rethrow()


func rethrow():
	captured = false
	translation = Vector3(50, 0, 0) # Reset position to middle
	
	# Since the ball doesn't fully slow down to 0, we can check its sign
	# to know which direction to throw the ball
	if sign(velocity.x) == -1: # The ball was going towards camera
		velocity = Vector3(1, 1, 1)
	else:
		velocity = Vector3(-1, 1, 1)
	
	set_speed(default_speed)
	
	# Pause the script for a moment to let the player react
	yield (get_tree().create_timer(1.5), "timeout")


# Callback function which is called when the ball hits the player's paddle
# You could make the CPU aim with a similar effect
func _on_aim_ball(trajectory : Vector3) -> void:
	velocity = trajectory.normalized() * speed


# When the ball enters a goal...

func _on_Goal1_body_entered(body) -> void:
	if body != self: return # Make sure stuff (like paddles) doesn't get checked
	captured = true
	

func _on_Goal2_body_entered(body) -> void:
	if body != self: return # See above
	captured = true
