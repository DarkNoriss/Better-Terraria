extends RigidBody2D

var health: int
var damage: int
var coins: int

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	health = 42
	damage = 18
	coins = 7


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	# if not is_on_floor():
	# 	velocity.y += gravity * delta

	# move_and_slide()

	pass
