extends CharacterBody2D

const SPEED: float = 500.0
const JUMP_VELOCITY: float = -375.0
const ACCELERATION: float = 400.0
const DECELERATION: float = 800.0
const VELOCITY_POWER: float = 0.9

const MAX_JUMP_PRESS_DURATION: float = 0.16
var jump_press_duration: float = 0.0

@onready var anim = get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	pass


func _process(_delta):
	pass


func _physics_process(delta):
	var direction: float = Input.get_axis("ui_left", "ui_right")

	playerJump(delta)

	playerMovement(direction, delta)

	setAnimations(direction)
	move_and_slide()


func playerMovement(direction, delta):
	# Apply gravity if the player is not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		# Calculate the target speed based on the direction
		var target_speed = Vector2(direction * SPEED, velocity.y)

		# Calculate the rate of acceleration or deceleration
		var accel_rate = ACCELERATION * delta

		if direction > 0 and velocity.x < 0 or direction < 0 and velocity.x > 0:
			accel_rate += DECELERATION * delta

		# Move the player towards the target speed at the calculated rate
		velocity = velocity.move_toward(target_speed, accel_rate)

	# If no direction is provided, decelerate the player to a stop
	if direction == 0:
		velocity = velocity.move_toward(Vector2(0, velocity.y), DECELERATION * delta)


func playerJump(delta):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_press_duration = 0.0
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("ui_accept") and jump_press_duration < MAX_JUMP_PRESS_DURATION:
		jump_press_duration += delta
		velocity.y = JUMP_VELOCITY
	elif (
		Input.is_action_just_released("ui_accept") or jump_press_duration >= MAX_JUMP_PRESS_DURATION
	):
		jump_press_duration = MAX_JUMP_PRESS_DURATION


func setAnimations(direction):
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true

	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false

	if is_on_floor():
		if direction == 0 and velocity.x == 0:
			anim.play("idle")

		else:
			anim.play("run")

	else:
		anim.play("jump")
