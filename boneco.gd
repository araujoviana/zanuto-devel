extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		update_animation(0)
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		update_animation(direction)
		velocity.x = direction * SPEED
	else:
		update_animation(direction)
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animation(direction: float):
	if not is_on_floor():
		sprite.play("jump")
	elif direction == 0:
		sprite.play("default")
	else:
		sprite.play("walk", 1.25)
		sprite.flip_h = -direction < 0
