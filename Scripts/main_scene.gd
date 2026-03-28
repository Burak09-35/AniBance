extends Node2D

@export var speed: float = 200
@export var left_limit: float = 150
@export var right_limit: float = 900

var direction := 1
var can_spawn := true

var next_box_scene: PackedScene

var box_scenes = [
	preload("res://Scenes/Box_1.tscn"),
	preload("res://Scenes/Box_1.tscn"),
	preload("res://Scenes/Box_1.tscn"),
	preload("res://Scenes/Box_1.tscn"),
	preload("res://Scenes/Box_2.tscn"),
	preload("res://Scenes/Box_2.tscn"),
	preload("res://Scenes/Box_2.tscn"),
	preload("res://Scenes/Box_3.tscn"),
	preload("res://Scenes/Box_3.tscn"),
	preload("res://Scenes/Box_4.tscn")
]

var score = 0
var game_is_over = false

func _ready():
	if !game_is_over:
		$AudioStreamPlayer2D2.play()
	randomize()
	$Control/DeadLine.body_entered.connect(_on_deadline_body_entered)
	update_score_label()
	
	# 👇 Pick the first previewed box at game start
	next_box_scene = box_scenes[randi() % box_scenes.size()]
	update_preview_texture()

func _process(delta):
	var some_limit_y = 1700
	if game_is_over == false and $Control/Balancestick.position.y > some_limit_y:
		game_over()

func _physics_process(delta):
	var x_pos = $Control/SpawnPoint.position.x + direction * speed * delta
	if x_pos > right_limit:
		x_pos = right_limit
		direction = -1
	elif x_pos < left_limit:
		x_pos = left_limit
		direction = 1
	$Control/SpawnPoint.position.x = x_pos
	$Control/TargetDot.position.x = x_pos

func _unhandled_input(event):
	if event.is_pressed() and can_spawn:
		spawn_box()
		can_spawn = false
		$SpawnTimer.start()

func spawn_box():
	if game_is_over == false:
		var box = next_box_scene.instantiate()
		box.position = $Control/SpawnPoint.position
		add_child(box)
		
		score += box.point_value
		update_score_label()

		# 👇 Prepare next one and update the preview
		next_box_scene = box_scenes[randi() % box_scenes.size()]
		update_preview_texture()

func update_preview_texture():
	var preview_instance = next_box_scene.instantiate()
	var texture = null

	# Look for Sprite2D in children (your box scenes are RigidBody2D)
	for child in preview_instance.get_children():
		if child is Sprite2D:
			texture = child.texture
			break

	preview_instance.queue_free()

	if texture != null:
		$Control/TextureRectPreview.texture = texture
		$Control/TextureRectPreview.scale = Vector2(0.4, 0.4)  # Shrink to 50%
	else:
		print("❌ Texture not found in preview scene!")


func update_score_label():
	$Control/UI/ScoreLabel.text = str(score)
	if GameManager.best_this_round_score < score:
		GameManager.best_this_round_score = score

func _on_deadline_body_entered(body):
	score -= body.point_value
	update_score_label()
	body.queue_free()

func _on_spawn_timer_timeout() -> void:
	can_spawn = true
	
func _on_fade_finished():
	get_tree().change_scene_to_file("res://Scenes/GameOverScreen.tscn")
	
func game_over():
	$AudioStreamPlayer2D.play()
	game_is_over = true
	var tween = create_tween()
	tween.tween_property($Control/CanvasLayer/RedOverlay, "color:a", 1.0, 1.0)
	tween.finished.connect(_on_fade_finished)


func _on_button_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/OpeningScreen.tscn")


func _on_button_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")


func _on_button_animals_page_pressed() -> void:
	get_tree().change_scene_to_file("res://Animals.tscn")
