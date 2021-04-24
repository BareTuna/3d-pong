extends Node

# This script does 2 things:

# 1) Detect when user presses R for restart

# 2) Set CPU difficulty
# 1 = easy
# 5 = my preference
# 9 = very, very hard
# 0 = humanly impossible

signal set_cpu_speed(speed)


func _process(delta) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	process_CPU_difficulty()


func process_CPU_difficulty():
	if Input.is_key_pressed(KEY_1):
		emit_signal("set_cpu_speed", 10)
	if Input.is_key_pressed(KEY_2):
		emit_signal("set_cpu_speed", 20)
	if Input.is_key_pressed(KEY_3):
		emit_signal("set_cpu_speed", 30)
	if Input.is_key_pressed(KEY_4):
		emit_signal("set_cpu_speed", 40)
	if Input.is_key_pressed(KEY_5):
		emit_signal("set_cpu_speed", 45)
	if Input.is_key_pressed(KEY_6):
		emit_signal("set_cpu_speed", 50)
	if Input.is_key_pressed(KEY_7):
		emit_signal("set_cpu_speed", 55)
	if Input.is_key_pressed(KEY_8):
		emit_signal("set_cpu_speed", 60)
	if Input.is_key_pressed(KEY_9):
		emit_signal("set_cpu_speed", 65)
	if Input.is_key_pressed(KEY_0):
		emit_signal("set_cpu_speed", 1000)
	
	
