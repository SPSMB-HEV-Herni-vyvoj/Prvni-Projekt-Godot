extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var isJump = false;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if ! is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	handleAnimatons(direction)
	move_and_slide()

	
	# Restart level if falling too fast
	if velocity.y > 2000:
		get_tree().change_scene_to_file("res://world.tscn")


func handleAnimatons(direction):
	if not is_on_floor():
		$PlayerAnimation.play("jump")
	elif direction != 0:
		$PlayerAnimation.play("walk")
		if direction == -1:
			$PlayerAnimation.flip_h = true
		elif direction == 1:
			$PlayerAnimation.flip_h = false
	else:
		$PlayerAnimation.play("idle")
