extends Button
@export var texto_personalizado: String

func _ready() -> void:
	text = texto_personalizado
