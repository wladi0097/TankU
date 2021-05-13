extends Control

onready var mapsContainer = $VBoxContainer/HBoxContaine/MapsContainer
onready var mapButton = preload("res://layout/LevelSelectButton.tscn")

func _ready():
	listMaps()
	pass 

func listMaps():
	for mapIndex in range(Global.maps.size()):
		var map = mapButton.instance()
		map.index = mapIndex
		mapsContainer.add_child(map)
