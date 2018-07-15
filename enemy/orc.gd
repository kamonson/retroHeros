extends "res://engine/entity.gd"

const SPEED = 100

var movetimer_length = 120
var movetimer = 0
var moveDirNow = dir.down

func _ready():
	movedir = dir.rand()

#main process, if unit is hurt stop all other loops and checks
func _physics_process(delta):
	if $anim.current_animation != "hurt" && life > 0:
		movement_loop()
		spritedir_loop()
		
		if movetimer > 0:
			movetimer -=1
		if movetimer == 0 || is_on_wall():
			movedir = dir.rand()
			movetimer = movetimer_length
	elif !$anim.is_playing() && life < 1:
		queue_free()	
		
	#enable for debuging
	#print("orc, ", $anim.current_animation)
	#print("orc, ", spritedir)
	#print("orc, ", movedir)
	#print("orc ", life)