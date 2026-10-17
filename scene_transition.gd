extends CanvasLayer

const OPEN := 2.5     # tela livre
const CLOSED := -0.2 # tela toda coberta

@onready var iris: ColorRect = $Iris
var _busy := false


func _ready() -> void:
	iris.visible = false
	iris.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_set_radius(OPEN)


func is_busy() -> bool:
	return _busy


func _set_radius(r: float) -> void:
	(iris.material as ShaderMaterial).set_shader_parameter("radius", r)


func _set_center(c: Vector2) -> void:
	(iris.material as ShaderMaterial).set_shader_parameter("center", c)


# Fecha o iris, executa a ação (trocar de cena, etc.) e reabre
func transition(on_covered: Callable, duration := 1.3, open_duration := 1.7) -> void:
	if _busy:
		return
	_busy = true

	# o círculo fecha em direção ao ponto clicado
	var vp := get_viewport()
	_set_center(vp.get_mouse_position() / vp.get_visible_rect().size)
	iris.visible = true
	iris.mouse_filter = Control.MOUSE_FILTER_STOP  # bloqueia cliques durante a transição

	var close_tween := create_tween()
	close_tween.tween_method(_set_radius, OPEN, CLOSED, duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await close_tween.finished

	on_covered.call()
	# a troca de cena só acontece no fim do frame, então espera dois
	await get_tree().process_frame
	await get_tree().process_frame

	# a nova fase abre a partir do centro
	_set_center(Vector2(0.5, 0.5))
	var open_tween := create_tween()
	open_tween.tween_method(_set_radius, CLOSED, OPEN, open_duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await open_tween.finished

	iris.visible = false
	iris.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_busy = false
