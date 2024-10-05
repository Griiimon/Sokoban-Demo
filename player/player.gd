class_name Player
extends DynamicLevelObject

var wait_for_key_release:= false

# the Player can move if..
func can_move(direction: Vector2i)-> bool:
	var target_grid_pos: Vector2i= grid_pos + direction

	# .. there's no object in the target grid
	if not get_level().has_object_at(target_grid_pos):
		return true

	var blocking_object: LevelObject= get_level().get_object_at(target_grid_pos)
	# .. or the object in the target grid can be moved in the same direction
	if blocking_object.can_move(direction):
		return true
	return false


func _process(delta: float) -> void:
	# make sure we wait for all keys to be released after we tried to
	# execute a move, so we dont move multiple tiles with one press
	if wait_for_key_release:
		if Input.is_anything_pressed():
			return
		wait_for_key_release= false

	var move_direction: Vector2i= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if move_direction:
		wait_for_key_release= true
		if can_move(move_direction):
			move(move_direction)
