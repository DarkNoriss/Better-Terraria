extends CharacterBody2D

var health: int = 42
var damage: int = 18
var coins: int = 7

var speed: float = 200
var jump_velocity: float = 600
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var player: CharacterBody2D
var player
var jumpDirection: String
var jumpTimer: float = 2.0
var jumpDirection: String


func _ready():
	player = get_node("../../Player")
	player = get_node("../../Player")

	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if is_on_floor():
		jumpTimer -= delta

		velocity.x = 0

		if jumpTimer <= 0.0:
			jumpTimer = 2.0

			if player.position.x > position.x:
				jumpDirection = "right"
			elif player.position.x < position.x:
				jumpDirection = "left"

			velocity.y -= 500

	if not is_on_floor():
		velocity.y += gravity * delta

		if jumpDirection == "right":
			velocity.x = speed
		elif jumpDirection == "left":
			velocity.x = -speed

	move_and_slide()

	pass


func _on_area_2d_body_entered(_body):
	# print("ENTERED BODY", body)

	pass
