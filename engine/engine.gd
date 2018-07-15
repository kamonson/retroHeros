extends Node

var viewport_scale

func _ready():
	var viewport = get_node("/root").get_children()[2].get_viewport().size
	#print(viewport)
	#viewport_scale = 300/viewport.y
	#print(viewport_scale)