extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@export_file("*.png", "*.jpg") var caminho_da_imagem: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if caminho_da_imagem != "":
		sprite.texture = load(caminho_da_imagem)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
