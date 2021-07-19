extends Node

var maps = [
	preload("res://maps/Map_01.tscn"),
	preload("res://maps/Map_02.tscn")
]

func _ready():
	OS.set_current_screen(1)
	OS.window_maximized = true

var player
func playerExists() -> bool:
	return is_instance_valid( player )

func getGlobalPlayerPosition() -> Vector2:
	return player.get_global_position() if is_instance_valid( player ) else Vector2()

func getPLayerInstance():
	return player
	
func getNavigationPolygonFromTileMap(tileMap: TileMap) -> NavigationPolygon:
	return tileMap.tile_set.tile_get_navigation_polygon(1)

func dead():
	DeathScreen.show()

func _input(event):
	if event.is_action_pressed("menu"):
		loadMainMenu()
	if event.is_action_pressed("reset"):
		reloadMap()

func loadMainMenu():
	DeathScreen.hide()
	get_tree().change_scene("res://layout/Main.tscn")
	
func reloadMap():
	DeathScreen.hide()
	get_tree().reload_current_scene()
