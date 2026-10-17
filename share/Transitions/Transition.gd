extends Node

@onready var rootNode = get_tree().root.get_node("root")

var path_scene: String;

func change_scene_with_transition(path_name_scene: String, use_iris := true):
	scene_change(path_name_scene, use_iris)

func scene_change(path_scene: String, use_iris := true) -> void:
	var newScene: Node = packedScene_for_Node(path_scene)
	if newScene == null:
		return
	_go_to(newScene, use_iris)

func scene_change_object(scene: Node, use_iris := true) -> void:
	_go_to(scene, use_iris)

func _go_to(scene: Node, use_iris: bool) -> void:
	if not use_iris:
		_swap_scene(scene)  # troca direta, sem animação
		return
	if SceneTransition.is_busy():
		scene.queue_free()  # descarta a instância extra de um clique duplo
		return
	SceneTransition.transition(func(): _swap_scene(scene))

# A troca em si, agora executada quando a tela está toda coberta
func _swap_scene(scene: Node) -> void:
	for child in rootNode.get_children():
		if child != null and child.name != "Global" and child.name != "TransitionsScreen":
			rootNode.remove_child(child)
			child.queue_free()

	rootNode.add_child(scene)

	rootNode.add_child(scene)

func fade_in() -> void:
	isVisible(true);

func fade_out() -> void:
	isVisible(false)

func packedScene_for_Node(path_scene: String):
	var packed: PackedScene = load(path_scene)
	if packed == null:
		push_error("Cena não encontrada: %s" % path_scene)
		return
	return packed.instantiate()

func isVisible(visible: bool):
	pass
