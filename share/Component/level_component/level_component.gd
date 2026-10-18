extends Node2D

@export var texto_personalizado: String
@export_file("*.png", "*.jpg", "*.jpeg") var imagem_path: String 
@export var botao_sobre_imagem: bool 
@onready var botao = $Button
@onready var sprite = $imagem

@export var mundo_aberto: bool 
# Adicionei o filtro "*.tscn" e o tipo String para garantir que só cenas sejam selecionadas
@export_file("*.tscn") var transition_Path: String 

func _ready() -> void:
	# 1. Configura o botão
	if texto_personalizado != "":
		botao.texto_personalizado = texto_personalizado
		botao.text = texto_personalizado 
		
	# 2. Configura a imagem do mundo
	if imagem_path != "":
		var textura = load(imagem_path)
		sprite.texture = textura
		
	# 3. Lógica para sobrepor o botão
	if botao_sobre_imagem:
		botao.z_index = sprite.z_index
		botao.position.y -= 570
		
	# 4. Lógica de habilitar/desabilitar o mundo
	# O botão fica desabilitado (disabled = true) se 'mundo_aberto' for falso
	botao.disabled = not mundo_aberto
	
	# 5. Conecta o clique do botão à função de mudança de cena
	# (Só será possível clicar se o botão não estiver desabilitado pelo passo 4)
	botao.pressed.connect(_on_botao_pressed)


# Nova função que será ativada quando o botão for clicado
func _on_botao_pressed() -> void:
	# Verifica se algum caminho foi colocado no inspetor para não quebrar o jogo
	if transition_Path != "":
		Transition.scene_change(transition_Path, true)
	else:
		print("Aviso: Caminho de transição não foi definido para o botão ", texto_personalizado)
