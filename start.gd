extends Control

func _on_StartGame_pressed():
	var main_scene = load("res://main.tscn")
	get_tree().change_scene_to(main_scene)

func _on_Quit_pressed():
	get_tree().quit()
