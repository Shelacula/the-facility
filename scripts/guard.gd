extends CharacterBody2D


const SPEED = 150.0

@onready var field_of_view: RayCast2D = $FieldOfView
@onready var wolfgirl: CharacterBody2D = $"../wolfgirl"

var playerLocation


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	playerLocation = wolfgirl.position

	if field_of_view.is_colliding():
		velocity = position.direction_to(playerLocation) * SPEED
		print("Seen!")
		print(playerLocation)
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
