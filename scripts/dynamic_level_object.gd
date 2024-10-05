class_name DynamicLevelObject
extends LevelObject

const MOVE_SPEED= 0.2

var move_tween: Tween
var grid_pos: Vector2i



func _ready() -> void:
	# make sure this runs after the parent ( the Level ) is already
	# initialized, because _ready() functions of the children run first
	await get_level().ready
	
	# calculate our grid position from our pixel position
	# ( from the position the Node was placed in the Editor )
	grid_pos= get_level().pixel_position_to_grid(position)

	# register this level object
	get_level().set_object.call_deferred(grid_pos, self)


# a DynamicLevelObject is able to move, but only if there's no object
# in the target grid
func can_move(direction: Vector2i)-> bool:
	var target_grid_pos: Vector2i= grid_pos + direction
	return not get_level().has_object_at(target_grid_pos)


func move(direction: Vector2i):
	#if move_tween and move_tween.is_running():
		#await move_tween.finished
	if move_tween:
		move_tween.kill()
	
	var target_grid_pos: Vector2i= grid_pos + direction
	
	var blocking_object: LevelObject= get_level().get_object_at(target_grid_pos)
	# if there's an object in our target grid cell, move that object first
	if blocking_object:
		blocking_object.move(direction)
		
	# update the position this object is registered to
	get_level().move_object(grid_pos, target_grid_pos, self)
	# update our grid position
	grid_pos= target_grid_pos
	
	move_tween= create_tween()
	move_tween.tween_property(self, "position", get_level().grid_position_to_pixel(target_grid_pos), MOVE_SPEED)
