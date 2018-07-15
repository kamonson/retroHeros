extends "res://engine/entity.gd"

#inherits and extends entity for player specific code

const 	SPEED = 70

func _physics_process(delta):
	#Player states
	controls_loop()
	movement_loop()
	spritedir_loop()
	hit_check_loop()
	
	#debuging
	#print($anim.current_animation)
	#print(spritedir)
	#print(movedir)
	
func controls_loop():	
	var LEFT 	= Input.is_action_pressed("ui_left")
	var RIGHT 	= Input.is_action_pressed("ui_right")
	var UP 		= Input.is_action_pressed("ui_up")
	var DOWN 	= Input.is_action_pressed("ui_down")
	
	if Input.is_action_pressed("ui_accept"):
		isAttack = true
	else: 
		isAttack = false
	
	#cast bool to int for negitive eval, if left is pushed then -1 if right is pushed +1 if both are pressed the no movement occurs
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)