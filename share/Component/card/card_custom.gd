extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@export_file("*.png", "*.jpg") var caminho_da_imagem: String
@export var order: int
@export var text: String

var active: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if caminho_da_imagem != "":
		sprite.texture = load(caminho_da_imagem)
	active = true
	$RichTextLabel.text = text
