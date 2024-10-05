class_name LevelObject
extends Node2D



func can_move(direction: Vector2i)-> bool:
	# basic LevelObjects cant move
	return false


func move(direction: Vector2i):
	# basic LevelObjects cant move
	pass


# assuming all level objects are direct children of our Level root node
func get_level()-> Level:
	return get_parent()
