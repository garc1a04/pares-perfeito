extends Node2D

@onready var placeholders = $table/CardOrder/HBoxContainer
@onready var cards = $table/CardManager
@onready var card_intrusa = $table/CardManager/Card6
@onready var mesa_fundo: ColorRect = $table/ColorRect
@onready var personagem: AnimatedSprite2D = $AnimatedSprite2D
var scene_world = preload("res://world/world1/main_world1.tscn")
var path = "res://world/world1/level/levels_1.tscn"

@export var min_x: float = 50.0
@export var max_x: float = 1100.0
@export var altura_y_fixa: float = 400.0
@export var margem_seguranca: float = 100

enum Level {
	MEMORIZACAO = 1,
	SILHUETA = 2,
	PRIMEIRA_CERTA = 3,
	DO_ZERO = 4,
	INTRUSA = 5
}

@export var nivel_atual: Level = Level.DO_ZERO
@onready var voltar: Button = $Personagem/voltar
func _ready() -> void:
	voltar.pressed.connect(_on_voltar)
	_config()

func _on_voltar() -> void:
	var path = "res://world/world1/level/levels_1.tscn"
	Transition.scene_change(path, true)

func _config():
	iniciar_nivel(nivel_atual)
	
	for placeholder in placeholders.get_children():
		if placeholder.has_signal("card_right"):
			placeholder.card_right.connect(_on_qualquer_placeholder_card_right)
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


func configurar_nivel_1():
	for c in placeholders.get_children():
		c.visible = true 
		c.sprite.visible = true
		c.sprite.modulate.a = 0.3

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
	var total_cartas = lista_de_cartas.size() - inicio_indice
	
	# Previne erros caso não haja cartas para embaralhar
	if total_cartas <= 0:
		return
		
	var min_x = mesa_fundo.global_position.x + margem_seguranca
	var max_x = mesa_fundo.global_position.x + mesa_fundo.size.x - margem_seguranca
	
	# Calcula a largura total disponível e o tamanho de cada "fatia" (slot) para as cartas
	var largura_disponivel = max_x - min_x
	var tamanho_do_slot = largura_disponivel / total_cartas
	
	var posicoes_x = []
	
	# 1. Gera as posições X uniformemente distribuídas
	for i in range(total_cartas):
		# Acha o meio exato do slot atual
		var posicao_base = min_x + (i * tamanho_do_slot) + (tamanho_do_slot / 2.0)
		
		# (Opcional) Adiciona uma variação minúscula dentro do próprio slot 
		# para a carta não parecer "colada com régua", mantendo um visual orgânico
		var variacao_organica = randf_range(-tamanho_do_slot * 0.15, tamanho_do_slot * 0.15)
		
		posicoes_x.append(posicao_base + variacao_organica)
		
	# 2. Embaralha a ordem das posições geradas
	posicoes_x.shuffle()
	
	# 3. Distribui as posições embaralhadas para as cartas
	var index_da_posicao = 0
	for i in range(inicio_indice, lista_de_cartas.size()):
		var card = lista_de_cartas[i]
		
		# Aplica a posição X única e a altura Y fixa
		card.global_position = Vector2(posicoes_x[index_da_posicao], altura_y_fixa)
		
		index_da_posicao += 1


func _on_qualquer_placeholder_card_wrong(card: Node2D) -> void:
	card.active = false

	for i in range(1):
		personagem.play("Blinking_wrong")
		await personagem.animation_finished
		
	personagem.play("Idle")

func _on_qualquer_placeholder_card_right(card: Node2D) -> void:
	for i in range(1):
		personagem.play("Blinking_right")
		await personagem.animation_finished
	personagem.play("Idle")

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
			if nivel_atual >= Level.INTRUSA:
				Transition.scene_change(path, true)
				return # Encerra aqui e volta para o menu de níveis
				
			# 2. Se não for o último, instanciamos a próxima fase
			var scene: Node = scene_world.instantiate()
			
			# 3. Faz o cast do número (+1) para o Enum (Level) para evitar erros de tipagem do Godot
			scene.nivel_atual = (nivel_atual + 1) as Level
			
			# 4. Transita para a nova cena
			Transition.scene_change_object(scene)

func devolver_carta_para_o_topo(carta: Node2D):
	var topo_y = mesa_fundo.global_position.y + margem_seguranca
	var tween = get_tree().create_tween()
	tween.tween_property(carta, "global_position:y", topo_y, 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_callback(func(): carta.active = true)
