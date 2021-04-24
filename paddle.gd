extends StaticBody

# Signal that tells the ball to re-aim after hitting our paddle
signal aim_ball(trajectory)

# Get a reference to the camera
# Needed to convert our mouse position on screen to in-game coordinates
onready var camera = $"../Camera"


func _ready() -> void:
	pass


func _process(delta) -> void:
	pass


func _input(event) -> void:
	if event is InputEventMouseMotion:
		# Create a plane (the thing our paddle moves on)
		# Project a ray from our mouse, and get the position it intersects the plane
		# and that's the new position of the paddle
		var drop_plane = Plane(Vector3(1, 0, 0), 1.01) # 1.01 prevents clipping from the gray walls
		var position_3D = drop_plane.intersects_ray(
			camera.project_ray_origin(event.position),
			camera.project_ray_normal(event.position)
		)
		translation = position_3D
		
		
func _on_ball_hit(collider : Spatial, sender : Spatial) -> void:
	if collider != self: return
	$AnimationPlayer.play("hit") # This gives the paddle that orange blip
	
	# Re-aim the ball.
	# I emit a signal for the ball script to figure out what to do
	# rather than modifying the ball's velocity directly
	emit_signal("aim_ball", sender.translation - translation)
