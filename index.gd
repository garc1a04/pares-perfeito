extends Node2D

@onready var btn_iniciar: Button = $button

func _ready() -> void:
	btn_iniciar.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	var path = "res://worlds.tscn"
	Transition.scene_change(path, true)
