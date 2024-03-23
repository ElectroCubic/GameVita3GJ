extends CharacterBody2D

@export var SPEED: int
@export var JUMP_VELOCITY: int
@export var jumpBufferTime: float
@export var coyoteTime: float
@export var pushForce: int
var jumpBufferCounter: float
var coyoteTimeCounter: float
var lowJumpMultiplier: float = 0.9

@onready var anim = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#var scale_decrease: float = 0
#var spriteHeight: int = 810

#func _ready():
	#scale_decrease += 0.1
	#$CollisionShape2D.scale -= Vector2(1 - scale_decrease, 1 - scale_decrease)
	#var spriteOffset = spriteHeight - (spriteHeight * $CollisionShape2D.scale.y)
	#$AnimatedSprite2D.position.y = (3 + spriteOffset)


func charMoveLeft():
	anim.flip_h = true
	if velocity.y == 0:
		anim.play("Move")

func charMoveRight():
	anim.flip_h = false
	if velocity.y == 0:
		anim.play("Move")

func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		coyoteTimeCounter = coyoteTime
	else:
		velocity.y += gravity * delta
		coyoteTimeCounter -= delta

	# Player Controls
	if (anim.animation != "Death") and not Globals.is_game_over:
		var direction = 0
		var left = Input.is_action_pressed("Left")
		var right = Input.is_action_pressed("Right")
		
		if left and not right:
			direction = -1
			charMoveLeft()
				
		elif right and not left:
			direction = 1
			charMoveRight()
		else:
			direction = 0
			velocity.x = move_toward(velocity.x,0,SPEED)

			if velocity.y == 0:
				anim.play("Idle")
			
		velocity.x = direction * SPEED
		
		# Handle Jump.
		if Input.is_action_pressed("Jump"):
			jumpBufferCounter = jumpBufferTime
		else:
			jumpBufferCounter -= delta
		
		if Input.is_action_pressed("Jump") and coyoteTimeCounter > 0 and jumpBufferCounter > 0:
			coyoteTimeCounter = 0
			jumpBufferCounter = 0
			velocity.y += JUMP_VELOCITY
			anim.play("Jump")

		elif velocity.y < 0 and not Input.is_action_pressed("Jump"):
			velocity.y += JUMP_VELOCITY * (lowJumpMultiplier - 1)
				
		# If player is mid-air
		if velocity.y > 0:
			anim.play("Fall")

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * pushForce)

func death():
	Globals.is_game_over = true
	anim.play("Death")
	print("You DIED")
