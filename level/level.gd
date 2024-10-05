class_name Level
extends Node2D


@onready var tile_map: TileMapLayer = $TileMapLayer

# here are all level objects stored, in the format
# key: GRID POSITION, value: OBJECT
var level_objects: Dictionary= {}

# one object that is used for all level walls or other tiles
# the player can't walk on
var level_wall= LevelObject.new()



func _ready() -> void:
	# loop through all tiles in our level TileMap and set all
	# unwalkable tiles to the wall object level_wall
	for tile_pos in tile_map.get_used_cells():
		var data: TileData= tile_map.get_cell_tile_data(tile_pos)
		if not data.get_custom_data("walkable"):
			set_object(tile_pos, level_wall)


# register this object to a grid position in our Dictionary
func set_object(grid_pos: Vector2i, object: LevelObject):
	level_objects[grid_pos]= object


# register this object to it's new grid position in our Dictionary
# and remove its previous position
func move_object(from_grid_pos: Vector2i, to_grid_pos: Vector2i, object: LevelObject):
	# if this object is still registered to its previous grid position..
	if level_objects.has(from_grid_pos) and level_objects[from_grid_pos] == object:
		# .. remove that grid position
		level_objects.erase(from_grid_pos)
	
	set_object(to_grid_pos, object)


func has_object_at(grid_pos: Vector2i)-> bool:
	return level_objects.has(grid_pos)


func get_object_at(grid_pos: Vector2i)-> LevelObject:
	if not level_objects.has(grid_pos):
		return null
	return level_objects[grid_pos]


# convert a grid position to a pixel position, according to the
# TileMaps tile size
func grid_position_to_pixel(grid_pos: Vector2i)-> Vector2:
	return tile_map.map_to_local(grid_pos)


# convert a pixel position to a TileMap grid position, according to the
# TileMaps tile size
func pixel_position_to_grid(grid_pos: Vector2i)-> Vector2:
	return tile_map.local_to_map(grid_pos)
