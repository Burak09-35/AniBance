# character_card.gd!
extends Control

func set_data(texture: Texture2D, size: int, weight: int, score: int) -> void:
	# HBoxContainer node'una erişim
	var hbox = $HBoxContainer
	if hbox == null:
		print("HBoxContainer bulunamadı!")
		return
	
	# TextureRect node'una erişim ve texture ayarı
	var tex_rect = $HBoxContainer/MarginTextureRect/TextureRect
	if tex_rect == null:
		print("TextureRect bulunamadı!")
	else:
		tex_rect.texture = texture

	# VBoxContainer node'una erişim
	var vbox = $HBoxContainer/VBoxContainer
	if vbox == null:
		print("VBoxContainer bulunamadı!")
	else:
			$HBoxContainer/VBoxContainer/MarginContainer/Label.text = "Size: " + str(size)
			$HBoxContainer/VBoxContainer/SizeContainer/Label.text = "Weight: " + str(weight)
			$HBoxContainer/VBoxContainer/ScoreContainer/Label.text = "Score: " + str(score)
