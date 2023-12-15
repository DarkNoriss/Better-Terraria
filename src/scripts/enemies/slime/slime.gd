extends CharacterBody2D

var health: int
var damage: int
var coins: int

var jump_velocity: float
var gravity: float

@onready var anim = get_node("AnimationPlayer")


func _ready():
	health = 42
	damage = 18
	coins = 7

	jump_velocity = 400
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

	pass


func _on_area_2d_body_entered(body):
	print("ENTERED BODY", body)
	pass  # Replace with function body.
