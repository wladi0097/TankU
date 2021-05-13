extends Node

func _ready():
	OS.set_current_screen(1)
	OS.window_maximized = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
func playerExists() -> bool:
	return is_instance_valid( player )

func getGlobalPlayerPosition() -> Vector2:
	return player.get_global_position() if is_instance_valid( player ) else Vector2()

func getPLayerInstance():
	return player
	
func getNavigationPolygonFromTileMap(tileMap: TileMap) -> NavigationPolygon:
	return tileMap.tile_set.tile_get_navigation_polygon(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
