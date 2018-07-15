extends KinematicBody2D

#Holds the basic movment and animation of player and NPC's
const 	SPEED = 0
const 	IS_Entity = true
var		life = 100

#which way to move 0,0 (idle) deafult is down
var 	movedir = dir.left
#which way the sprite faces, default down
var 	spritedir = "Down"
var		isAttack = false

#movement will slide along aslong as keyy is pressed, and no collision occurs, a constant rate	
func movement_loop():
	if !isAttack:
		var motion = movedir.normalized() * SPEED
		move_and_slide(motion, dir.center)
	
#sprite will match the movement imputted by user
func spritedir_loop():
	#switch statment
	match movedir:
		dir.left:
			spritedir = "Left"
		dir.right:
			spritedir = "Right"
		dir.up:
			spritedir = "Up"
		dir.down:
			spritedir = "Down"
	if !isAttack:
		if movedir != dir.center:
			anim_switch("walk")
		else:
			anim_switch("idle")
	else:
		anim_switch("attack")

func anim_switch(animation):
	#create string for animation type and direction format: idleUp walkDown
	var newanim = str(animation,spritedir)
	# $ means get node
	if $anim.current_animation != newanim:
		$anim.play(newanim)

#hurt logic for all entity based chars, take life then play hurt if dead
func hurt():
	life -= 1
	if life < 1:
		$anim.play("hurt")
	#for debugging
	#print("ouch!")

#check to see if char is attacking, if so make a bump in the attacking direction to trigger collison
func hit_check_loop():
	if isAttack:
		var attackDir = "none"
		var collision_info = null
		match movedir:
			dir.left:
				collision_info = move_and_collide(dir.left)
				attackDir = "left "
			dir.right:
				collision_info = move_and_collide(dir.right)
				attackDir = "right "
			dir.up:
				collision_info = move_and_collide(dir.up)
				attackDir = "up "
			dir.down:
				collision_info = move_and_collide(dir.down)
				attackDir = "down"
		#if collision with a char, KinematicBody2D, hurt char
		#environment is tilemap and npc would be toped up on health each loop
		if collision_info:
			if collision_info.get_collider().get_class() == "KinematicBody2D":
				collision_info.get_collider().hurt()
			#for debugging
				#print(attackDir, "hit")
				#print(collision_info.get_collider().hurt())
				#print(collision_info.get_collider().get_class())