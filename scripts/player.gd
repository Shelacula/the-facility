extends CharacterBody2D


# const JUMP_VELOCITY = -200.0
const SPEED = 100.0
const MAX_STAMINA = 30

var stamina = 0

signal stamina_update

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_bar: ColorRect = $UI/StaminaBar

func _ready():
	stamina_update.connect(stamina_bar.update_stamina_bar)
	stamina = MAX_STAMINA


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		animated_sprite.play("walk_right")
	elif direction < 0:
		animated_sprite.flip_h = true
		animated_sprite.play("walk_left")
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
			animated_sprite.flip_h = false
			stamina = min(stamina + (delta * 10), MAX_STAMINA)
			if stamina < MAX_STAMINA:
				stamina_update.emit(stamina, MAX_STAMINA)
	
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_pressed("sprint") && stamina > 0:
			velocity.x *= 2
			stamina -= 10 * delta
			stamina_update.emit(stamina, MAX_STAMINA)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
