extends Label

# This is the score for YOU

# Get the original text so we can pass the score variable in
onready var original_text := text

var score := 0


func _ready():
	# By default the score text says "YOU: %s"
	# Update it so it says "YOU: 0"
	update_score()


func _on_Goal2_body_entered(body):
	if body.get_class() != "Ball": return
	# The ball went into the goal! You get a point!
	score += 1
	update_score()


func update_score():
	text = original_text % [str(score)]
