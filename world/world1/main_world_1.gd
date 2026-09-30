extends Node2D

@onready var placeholders = $CardOrder/HBoxContainer
@onready var cards = $CardManager
@onready var card_intrusa = $CardManager/Card6
@export var min_x: float = 50.0
@export var max_x: float = 1100.0
@export var min_y: float = 50.0
@export var max_y: float = 400.0

enum Level {
	MEMORIZACAO = 1,
	SILHUETA = 2,
	PRIMEIRA_CERTA = 3,
	DO_ZERO = 4,
	INTRUSA = 5
}

@export var nivel_atual: Level = Level.SILHUETA

func _ready() -> void:
	_config()

func _config():
	iniciar_nivel(nivel_atual)
	for placeholder in placeholders.get_children():
		if placeholder.has_signal("card_wrong"):
			placeholder.card_wrong.connect(_on_qualquer_placeholder_card_wrong)

func iniciar_nivel(nivel: Level):
	match nivel:
		Level.MEMORIZACAO:
			configurar_nivel_1()
		Level.SILHUETA:
			configurar_nivel_2()
		Level.PRIMEIRA_CERTA:
			configurar_nivel_3()
		Level.DO_ZERO:
			configurar_nivel_4()
		Level.INTRUSA:
			configurar_nivel_5()


# TALVEZ AQUI SEJA ALGUMA ANIMACÃO MOSTRANDO ALGO OU SEI LÁ, PQ FICOU ESTRANHO
# SER APENAS MOVER PARA BAIXO


func configurar_nivel_1():
	pass

func configurar_nivel_2():
	for c in placeholders.get_children():
		c.visible = true 
		c.sprite.visible = true
		c.sprite.modulate.a = 0.3

func configurar_nivel_3():
	var lista_de_cartas = cards.get_children()
	if lista_de_cartas.is_empty(): return
	
	colocar_first_card(lista_de_cartas[0])
	embaralhar_cartas(1)

func colocar_first_card(carta: Node2D):
	var primeiro_slot = placeholders.get_child(0)
	carta.global_position += Vector2(-3,170)
	primeiro_slot.carta_no_slot = carta
	carta.active = false

func configurar_nivel_4():
	embaralhar_cartas(0)

func configurar_nivel_5():
	card_intrusa.visible = true
	embaralhar_cartas(0)

func embaralhar_cartas(inicio_indice: int) -> void:
	var lista_de_cartas = cards.get_children()
	for i in range(inicio_indice, lista_de_cartas.size()):
		var card = lista_de_cartas[i]
		var random_x = randf_range(min_x, max_x)
		var random_y = randf_range(min_y, max_y)
		card.global_position = Vector2(random_x, random_y)

func _on_qualquer_placeholder_card_wrong(card: Node2D) -> void:
	card.active = false

func _on_card_manager_win() -> void:
	check_win()

func check_win() -> void:
	await get_tree().create_timer(0.3).timeout
	var placeholders_nodes = placeholders.get_children(false)

	var todos_preenchidos = true
	for slot in placeholders_nodes:
		if slot.carta_no_slot == null:
			todos_preenchidos = false
			break

	if todos_preenchidos:
		var todas_corretas = true
		for slot in placeholders_nodes:
			if slot.carta_no_slot.order != slot.order:
				todas_corretas = false
				devolver_carta_para_o_topo(slot.carta_no_slot)
				slot.carta_no_slot = null 

		if todas_corretas:
			var path = "res://levels.tscn"
			Transition.scene_change(path)

func devolver_carta_para_o_topo(carta: Node2D):
	var tween = get_tree().create_tween()
	tween.tween_property(carta, "position:y", 125, 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(func(): carta.active = true)
