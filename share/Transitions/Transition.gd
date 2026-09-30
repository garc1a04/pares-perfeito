extends Node

@onready var rootNode = get_tree().root.get_node("root")

var path_scene: String;

func change_scene_with_transition(path_name_scene: String):
	scene_change(path_name_scene)

func scene_change(path_scene: String) -> void:
	var newScene: Node = packedScene_for_Node(path_scene)
	
	for child in rootNode.get_children():
		if child != null and child.name != "Global" and child.name != "TransitionsScreen":
			rootNode.remove_child(child)
			child.queue_free()

	rootNode.add_child(newScene)

func scene_change_object(scene: Node) -> void:
	for child in rootNode.get_children():
		if child != null and child.name != "Global" and child.name != "TransitionsScreen":
			rootNode.remove_child(child)
			child.queue_free()

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
