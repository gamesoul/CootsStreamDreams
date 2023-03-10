extends Node

var health := 4
var remaining_health := 4
var previous_health := 4

var default_speed := 1.0
var current_speed := default_speed
var default_add_speed := .15
var add_speed := default_add_speed

var previous_success := true

var level_amount := 0
var speed_level_amount := 0

var animation_speed := .9

var is_regular := true

var chess_games := [
	"res://microgames/Chess/DEFChess.tscn",
	"res://microgames/Chess/Chess2.tscn",
	"res://microgames/Chess/Chess3.tscn"
	]
var button_games := [
	"res://microgames/Button/DEFButton.tscn",
	"res://microgames/Button/Button2.tscn",
	"res://microgames/Button/Button3.tscn"
]
var amongus_games := [
	"res://microgames/AmongUs/DEFAmongUs.tscn",
	"res://microgames/AmongUs/AmongUsBlack.tscn",
	"res://microgames/AmongUs/AmongUsBlue.tscn",
	"res://microgames/AmongUs/AmongUsPink.tscn",
	"res://microgames/AmongUs/AmongUsRed.tscn",
	"res://microgames/AmongUs/AmongUsYellow.tscn"
]
var treat_games :=[
	"res://microgames/Treat/DEFTreat.tscn",
	"res://microgames/Treat/Treat2.tscn",
	"res://microgames/Treat/Treat3.tscn",
	"res://microgames/Treat/Treat4.tscn"
]
var signing_games :=[
	"res://microgames/Signature/DEFSignature.tscn"
]
var mogul_money :=[
	"res://microgames/MogulMoney/DEFMogulMoney.tscn",
	"res://microgames/MogulMoney/MogulMoney2.tscn",
	"res://microgames/MogulMoney/MogulMoney3.tscn",
	"res://microgames/MogulMoney/MogulMoney4.tscn",
	"res://microgames/MogulMoney/MogulMoney5.tscn",
	"res://microgames/MogulMoney/MogulMoney6.tscn"
]
var luddy_games :=[
	"res://microgames/Luddy/DEFLuddy.tscn"
]
var whomp_games :=[
	"res://microgames/Whomp/DEFWhomp.tscn"
]
var typing_games :=[
	"res://microgames/Typing/DEFTyping.tscn"
]
var all_game_levels := [
	chess_games,
	button_games,
	amongus_games,
	treat_games,
	signing_games,
	mogul_money,
	luddy_games,
	whomp_games,
	typing_games
	]
	
var current_game_levels : Array = all_game_levels.duplicate()


func _initialize() -> void:
	speed_level_amount = 0
	remaining_health = health
	previous_health = remaining_health
	current_speed = default_speed
	add_speed = default_add_speed
	level_amount = 0
	current_game_levels = all_game_levels.duplicate()


func _next_level() -> String:
	if current_game_levels.size() <= 0:
		current_game_levels = all_game_levels.duplicate()
	var current_array_size = current_game_levels.size()
	var next_level_key = randi() % current_array_size
	var current_game = current_game_levels[next_level_key]
	var pick_level = randi() % current_game.size()
	var now_level : String = current_game[pick_level]
	current_game_levels.remove(next_level_key)
	return now_level

func speed_up():
	current_speed += add_speed
	speed_level_amount = 0
	if animation_speed <= 0.1:
		animation_speed = 0.2
	else:
		animation_speed -= .05
	if add_speed <= 0:
		add_speed = .10
	else:
		add_speed -= 0.02
	print("Speed Up: " + str(current_speed))
