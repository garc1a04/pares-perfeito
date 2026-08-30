extends Node2D

signal win
var screen_size
var card_being_dragged

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.global_position = Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				card_being_dragged = card
		else: 
			if card_being_dragged != null:
				if not card_being_dragged.active:
					devolver_carta_para_o_topo(card_being_dragged)
				win.emit()
			card_being_dragged = null

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = space_state.intersect_point(parameters)

	for hit in result:
		var potential_card = hit.collider.get_parent()
		if potential_card in get_children():
			return potential_card
	return null

func devolver_carta_para_o_topo(carta: Node2D):
	var tween = get_tree().create_tween()
	tween.tween_property(carta, "position:y", 125, 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(func(): carta.active = true)
