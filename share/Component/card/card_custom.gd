extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@export_file("*.png", "*.jpg") var caminho_da_imagem: String
@export var order: int

var active: bool

func _ready() -> void:
	if caminho_da_imagem != "":
		sprite.texture = load(caminho_da_imagem)
	active = true
