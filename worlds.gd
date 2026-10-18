extends Node2D

@onready var voltar = $voltar

func _ready() -> void:
	voltar.pressed.connect(_on_voltar)

func _process(delta: float) -> void:
	pass

func _on_button_button_down() -> void:
	var path = "res://levels.tscn"
	Transition.scene_change(path, true)

func _on_voltar() -> void:
	var path = "res://index.tscn"
	Transition.scene_change(path, true)
