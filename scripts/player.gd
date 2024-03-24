extends CharacterBody2D

signal collided(collision)
signal playerDied

@export var SPEED: int
@export var JUMP_VELOCITY: int
@export var jumpBufferTime: float
@export var coyoteTime: float
@export var pushForce: int
var jumpBufferCounter: float
var coyoteTimeCounter: float
var lowJumpMultiplier: float = 0.9

@onready var anim = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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
	if (anim.animation != "Death"):
		var direction = 0
		var left = Input.is_action_pressed("Left")
		var right = Input.is_action_pressed("Right")
		
		if velocity and is_on_floor():
			if $WalkTimer.time_left <= 0:
				$WalkSound.pitch_scale = randf_range(0.8,1.2)
				$WalkSound.play()
				$WalkTimer.start(0.2)
			$WalkParticles.emitting = true
		else:
			$WalkParticles.emitting = false
		
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
			$JumpSound.play()
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
		collided.emit(collision)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * pushForce)

func death():
	if not $DeathSound.playing and not Globals.is_game_over:
		$DeathSound.play()
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",0,1)
	anim.play("Death")
	$DeathParticles.emitting = true
	if not Globals.is_game_over:
		Globals.health -= 1
	Globals.is_game_over = true
	await get_tree().create_timer(1).timeout
	playerDied.emit()
	queue_free()
