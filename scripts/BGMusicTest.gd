extends AudioStreamPlayer

var bg_music := preload("res://sound/We Shop Song.ogg")

func _ready() -> void:
	pitch_scale = 1

func speed_up():
	stop()
	stream = bg_music
	pitch_scale = Global.current_speed
	play()
	
func bg_music():
	if stream != bg_music:
		stop()
		stream = bg_music
		pitch_scale = Global.current_speed
		play()
	
func menu_music():
	stop()
	stream = preload("res://sound/cootsdreams_mainmenu.wav")
	pitch_scale = 1
	play()