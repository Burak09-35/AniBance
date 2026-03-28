extends VBoxContainer

@onready var character_card_scene = preload("res://Scenes/CharacterCard.tscn")

var animals = [
	{
		"texture": preload("res://Textures/bird2(resized).png"),
		"size": 1,
		"weight": 1,
		"score": 1
	},
	{
		"texture": preload("res://Textures/maynun(resized).png"),
		"size": 2,
		"weight": 2,
		"score": 2
	},
	{
		"texture": preload("res://Textures/domuz(resized).png"),
		"size": 4,
		"weight": 5,
		"score": 3
	},
	{
		"texture": preload("res://Textures/elephant(resized).png"),
		"size": 7,
		"weight": 7,
		"score": 4
	}
]

func _ready():
	for animal in animals:
		var card = character_card_scene.instantiate()
		add_child(card)
		card.set_data(animal["texture"], animal["size"], animal["weight"], animal["score"])
