extends Control

signal card_wrong(card: Node2D)

@onready var sprite: Sprite2D = $Sprite2D
@export_file("*.png", "*.jpg") var caminho_da_imagem: String
@export var order: int
var carta_no_slot: Node2D = null

func _ready() -> void:
	if caminho_da_imagem != "":
		sprite.texture = load(caminho_da_imagem)

var has_card: bool: 
	get: 
		return carta_no_slot != null

func _on_area_2d_area_entered(area: Area2D) -> void:
	var objeto_que_colidiu = area.get_parent() as Node2D

	if objeto_que_colidiu == null or not "order" in objeto_que_colidiu:
		return 

	if carta_no_slot == null:
		objeto_que_colidiu.active = true 
		carta_no_slot = objeto_que_colidiu
		if objeto_que_colidiu.order != order:
			card_wrong.emit(objeto_que_colidiu)

func _on_area_2d_area_exited(area: Area2D) -> void:
	var objeto_que_saiu = area.get_parent()
	if objeto_que_saiu == carta_no_slot:
		carta_no_slot = null
