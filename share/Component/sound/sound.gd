extends CheckButton

@onready var music_player = get_node("/root/MusicPlayer")

func _ready() -> void:
	toggled.connect(_on_toggled)

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		music_player.play() # Liga a música
	else:
		music_player.stop() # Desliga a música
