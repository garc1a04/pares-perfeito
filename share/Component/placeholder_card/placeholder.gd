extends Control

signal card_wrong(card: Node2D)

@export var order: int
var carta_no_slot: Node2D = null

var isCard: bool: 
	get: 
		return carta_no_slot != null

func _on_area_2d_area_entered(area: Area2D) -> void:
	var objeto_que_colidiu = area.get_parent() as Node2D
	if not "order" in objeto_que_colidiu:
		return 
		
	if objeto_que_colidiu.order == order and carta_no_slot == null:
		objeto_que_colidiu.active = true
		carta_no_slot = objeto_que_colidiu
		return
		
	card_wrong.emit(objeto_que_colidiu)

func _on_area_2d_area_exited(area: Area2D) -> void:
	var objeto_que_saiu = area.get_parent()
	
	if objeto_que_saiu == carta_no_slot:
		carta_no_slot = null
