extends "DefaultGame.gd"

#Interactions
func _input(event: InputEvent) -> void:
	if mouse_over and event.is_action_pressed("click"):
		sfx.interact()
		current_step += 1
		print(str(current_step))
		animation_steps.play("step" + str(current_step))
	elif event.is_action_pressed("click"):
		sfx.interact()
		is_over_failure()

func no_longer_mouse_over() -> void:
	mouse_over = false
