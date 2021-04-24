extends Label

# This is the score for the CPU

# Get the original text so we can pass the score variable in
onready var original_text := text

var score := 0


func _ready():
	# By default the score text says "CPU: %s"
	# Update it so it says "CPU: 0"
	update_score()


func _on_Goal1_body_entered(body):
	if body.get_class() != "Ball": return
	# The ball went into your goal... the CPU gets a point
	score += 1
	update_score()


func update_score():
	text = original_text % [str(score)]
