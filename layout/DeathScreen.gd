extends CanvasLayer

func show():
	$Control.visible = true
	
func hide():
	$Control.visible = false

func _on_Retry_button_down():
	Global.reloadMap()

func _on_MainMenu_button_down():
	Global.loadMainMenu()
