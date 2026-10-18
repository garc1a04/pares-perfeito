extends Node2D
enum Level {
	MEMORIZACAO = 1,
	SILHUETA = 2,
	PRIMEIRA_CERTA = 3,
	DO_ZERO = 4,
	INTRUSA = 5
}

# Começamos no primeiro nível
var nivel_atual: int = 1
var scene_world = preload("res://world/world1/main_world1.tscn")

# Referências aos nós filhos na sua cena
@onready var label: Label = $carrosel/Label
@onready var btn_esquerda: Button = $carrosel/esquerda
@onready var btn_direita: Button = $carrosel/direita
@onready var btn_iniciar: Button = $Button
@onready var voltar:Button = $voltar

func _ready() -> void:
	btn_esquerda.pressed.connect(_on_esquerda_pressed)
	btn_direita.pressed.connect(_on_direita_pressed)
	btn_iniciar.pressed.connect(_on_button_pressed)
	voltar.pressed.connect(_on_voltar)
	atualizar_carrossel()

func _on_esquerda_pressed() -> void:
	# Impede que o valor desça abaixo de 1
	if nivel_atual > 1:
		nivel_atual -= 1
		atualizar_carrossel()

func _on_direita_pressed() -> void:
	if nivel_atual < Level.size():
		nivel_atual += 1
		atualizar_carrossel()
		
func _on_button_pressed() -> void:
	var scene: Node = scene_world.instantiate()
	scene.nivel_atual = nivel_atual
	Transition.scene_change_object(scene)

func atualizar_carrossel() -> void:
	var nome_do_enum = Level.keys()[nivel_atual - 1]
	label.text = nome_do_enum.replace("_", " ").capitalize()

func _on_voltar() -> void:
	var path = "res://world/world1/level/levels_1.tscn"
	Transition.scene_change(path, true)
