extends Control

onready var mapsContainer = $VBoxContainer/HBoxContaine/MapsContainer
onready var credits = $credits
onready var mapButton = preload("res://layout/LevelSelectButton.tscn")

func _ready():
	listMaps()
	pass 

func listMaps():
	for mapIndex in range(Global.maps.size()):
		var map = mapButton.instance()
		map.index = mapIndex
		mapsContainer.add_child(map)


func _on_Button_button_down():
	credits.visible = true


func _on_credits_gui_input(event: InputEvent):
	if event.is_action_pressed("leftClick"):
		credits.visible = false
