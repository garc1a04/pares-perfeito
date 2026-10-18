extends Node2D

var scene_world = preload("res://world/world1/main_world1.tscn")

@onready var voltar = $voltar

func _ready() -> void:
	voltar.pressed.connect(_on_voltar)

func _process(delta: float) -> void:
	pass

func _on_voltar() -> void:
	var path = "res://worlds.tscn"
	Transition.scene_change(path, true)
