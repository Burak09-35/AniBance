extends AudioStreamPlayer2D

func _ready():
	finished.connect(_on_finished)  # Müzik bittiğinde sinyali dinle

func _on_finished():
	play()  # Müziği yeniden başlat
