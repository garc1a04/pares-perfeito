extends CanvasLayer

const OPEN := 3.0        # estado de repouso (iris invisível)
const CLOSED := -0.2     # tela toda coberta (precisa ser menor que -softness do shader)
const MARGIN := 0.2      # folga para cobrir a borda suave do círculo
const UNLOCK_AT := 0.5   # fração da abertura em que os cliques são liberados (0 a 1)

@onready var iris: ColorRect = $Iris
var _busy := false
var _radius := OPEN
var _tween: Tween


func _ready() -> void:
	iris.visible = false
	iris.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_set_radius(OPEN)


func is_busy() -> bool:
	return _busy


func _set_radius(r: float) -> void:
	_radius = r
	(iris.material as ShaderMaterial).set_shader_parameter("radius", r)


func _set_center(c: Vector2) -> void:
	(iris.material as ShaderMaterial).set_shader_parameter("center", c)


# Menor raio que revela a tela inteira para um círculo com esse centro
func _reveal_radius(center: Vector2, aspect: float) -> float:
	var dx := maxf(center.x, 1.0 - center.x) * aspect
	var dy := maxf(center.y, 1.0 - center.y)
	return sqrt(dx * dx + dy * dy) + MARGIN


func _unlock() -> void:
	iris.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_busy = false


func _finish() -> void:
	iris.visible = false


# Fecha o iris, executa a ação (trocar de cena, etc.) e reabre
func transition(on_covered: Callable, duration := 0.9, open_duration := 1.0) -> void:
	if _busy:
		return
	_busy = true

	# se ainda estava abrindo, cancela a animação antiga
	var was_opening := iris.visible
	if _tween:
		_tween.kill()

	var vp := get_viewport()
	var size := vp.get_visible_rect().size
	var aspect := size.x / size.y

	# o círculo fecha em direção ao ponto clicado
	var click_center := vp.get_mouse_position() / size
	_set_center(click_center)
	var start_radius := _radius if was_opening else _reveal_radius(click_center, aspect)
	_set_radius(start_radius)
	iris.visible = true
	iris.mouse_filter = Control.MOUSE_FILTER_STOP  # bloqueia cliques durante o fechamento

	_tween = create_tween()
	_tween.tween_method(_set_radius, start_radius, CLOSED, duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await _tween.finished

	on_covered.call()
	# a troca de cena só acontece no fim do frame, então espera dois
	await get_tree().process_frame
	await get_tree().process_frame

	# a nova fase abre a partir do centro, só até revelar a tela toda
	var center := Vector2(0.5, 0.5)
	_set_center(center)
	var end_radius := _reveal_radius(center, aspect)

	_tween = create_tween()
	_tween.tween_method(_set_radius, CLOSED, end_radius, open_duration) \
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	# libera os cliques no meio da abertura, em paralelo ao movimento
	_tween.parallel().tween_callback(_unlock).set_delay(open_duration * UNLOCK_AT)
	# esconde o iris só quando tudo terminou
	_tween.tween_callback(_finish)
