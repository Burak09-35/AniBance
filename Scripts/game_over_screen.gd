extends Control

func _ready():
	$AudioStreamPlayer2D.play()
	$ScoreLabel.text = str("Score: %d") % GameManager.best_this_round_score
	
func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/OpeningScreen.tscn")
