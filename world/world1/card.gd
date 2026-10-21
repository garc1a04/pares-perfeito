extends Node2D

signal win
var screen_size
var card_being_dragged
@onready var personagem: AnimatedSprite2D = $"../../AnimatedSprite2D"

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var table: ColorRect = $"../ColorRect"
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		card_being_dragged.global_position = Vector2(clamp(mouse_pos.x, table.global_position.x, screen_size.x), clamp(mouse_pos.y, table.global_position.y + 80, screen_size.y))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				personagem.animation = "Thinking"
				card_being_dragged = card
				card_being_dragged.z_index = 100
		else: 
			if card_being_dragged != null:
				card_being_dragged.z_index = 0
				win.emit()
			card_being_dragged = null
			personagem.animation = "Idle"

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
