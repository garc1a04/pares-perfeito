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

# Referências aos nós filhos na sua cena
@onready var label: Label = $Label
@onready var btn_esquerda: Button = $esquerda
@onready var btn_direita: Button = $direita

func _ready() -> void:
	btn_esquerda.pressed.connect(_on_esquerda_pressed)
	btn_direita.pressed.connect(_on_direita_pressed)
	
	# Atualiza a label logo que a cena carrega
	atualizar_carrossel()

func _on_esquerda_pressed() -> void:
	# Impede que o valor desça abaixo de 1
	if nivel_atual > 1:
		nivel_atual -= 1
		atualizar_carrossel()

func _on_direita_pressed() -> void:
	# Level.size() retorna 5. Impede que passe do limite máximo do Enum
	if nivel_atual < Level.size():
		nivel_atual += 1
		atualizar_carrossel()

func atualizar_carrossel() -> void:
	var nome_do_enum = Level.keys()[nivel_atual - 1]
	label.text = nome_do_enum.replace("_", " ").capitalize()
