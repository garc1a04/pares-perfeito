extends Node2D

var scene_world = preload("res://world/world1/main_world1.tscn")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = 1
	Transition.scene_change_object(scene)

func _on_button_2_button_down() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = 2
	Transition.scene_change_object(scene)

func _on_button_3_button_down() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = 3
	Transition.scene_change_object(scene)

func _on_button_4_button_down() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = 4
	Transition.scene_change_object(scene)
	
func _on_button_5_button_down() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = 5
	Transition.scene_change_object(scene)
