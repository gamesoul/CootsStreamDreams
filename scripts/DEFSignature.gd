extends Node2D

onready var timer := $Timer
onready var animation_steps := $AnimationPlayer
onready var animation_timer := $AnimationTimer
onready var label_game_text := $GameText
onready var sfx := $SFX
onready var draw := $Drawings

export var timer_time := 3.0
export var area_array : Array = []
export var step_amounts := 1
export var game_text : String
export var mouse_success : int

var mouse_over := false
var is_success := false
var current_step := 1
var current_speed := Global.current_speed
var already_failed := false
var mouse_amount : int

func _ready() -> void:
	Input.set_custom_mouse_cursor(preload("res://textures/signature/signingPENCIL.png"))
	sfx.start()
	for area in area_array:
		if area:
			var current_area = get_node(area)
			current_area.connect("mouse_entered", self, "_on_mouse_entered")
			current_area.connect("mouse_exited", self, "_on_mouse_exited")
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = timer_time / current_speed
	label_game_text.text = game_text
	animation_steps.playback_speed = current_speed
	animation_timer.playback_speed = current_speed
	animation_steps.play("step" + str(current_step))
	animation_timer.play("text")
	yield(animation_timer,"animation_finished")
	animation_timer.play("timer")
	timer.start()
	


func _process(delta: float) -> void:
	if mouse_amount > (mouse_success / Global.current_speed):
		is_over_success()
	
func _input(event: InputEvent) -> void:
	if InputEventMouseMotion and mouse_over:
		mouse_amount += 1
		print(mouse_amount)
		draw.is_drawing = true
	else:
		draw.is_drawing = false
		

#Interactions

func _on_mouse_entered() -> void:
	mouse_over = true
	
func _on_mouse_exited() -> void:
	mouse_over = false

#Special
func is_over_success() -> void:
	is_success = true
	disable()
	Global.previous_success = true
	sfx.success()
	animation_steps.play("success")
	yield(animation_steps, "animation_finished")
	transition_out()
	
func is_over_failure() -> void:
	if !already_failed:
		disable()
		Global.remaining_health -= 1
		already_failed = true
		Global.previous_success = false
		sfx.fail()
		animation_steps.play("failed")
		yield(animation_steps, "animation_finished")
		transition_out()
	
func disable() -> void:
	set_process_input(false)
	set_process(false)
	
func transition_out() -> void:
	SceneTransition.change_scene("res://uiscenes/Inbetween.tscn","dissolve")

#Timer
func _on_timer_timeout() -> void:
	if !is_success:
		is_over_failure()

