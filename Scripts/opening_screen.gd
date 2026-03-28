extends Control

func _ready():
	$AudioStreamPlayer2D.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
