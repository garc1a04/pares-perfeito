extends Node2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

func _on_button_button_down() -> void:
	var path = "res://worlds.tscn"
	Transition.scene_change(path)
