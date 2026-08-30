extends Node2D

@onready var placeholders = $CardOrder/HBoxContainer

func _ready() -> void:
	for placeholder in placeholders.get_children():
		if placeholder.has_signal("card_wrong"):
			placeholder.card_wrong.connect(_on_qualquer_placeholder_card_wrong)

func _on_qualquer_placeholder_card_wrong(card: Node2D) -> void:
	card.active = false

func _on_card_manager_win() -> void:
	checar_vitoria()
	
func checar_vitoria() -> void:
	await get_tree().create_timer(0.5).timeout
	var childrens = placeholders.get_children(false)
	var todos_sao_cards = childrens.all(func(child): return child.carta_no_slot != null)
	if todos_sao_cards:
		print("WIN")
