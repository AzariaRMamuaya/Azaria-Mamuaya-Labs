extends CharacterBody3D

@export var speed := 5.0
@export var jump_velocity := 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_jumping = false

func _physics_process(delta):
	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1
	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1

	input_dir = input_dir.normalized()

	# ✅ Flip both X and Z axes
	var direction = Vector3(-input_dir.x, 0, -input_dir.y).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if not is_on_floor():
		velocity.y -= gravity * delta
		if not is_jumping:
			play_animation("Jump_Start")
			is_jumping = true
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = jump_velocity
		play_animation("Jump_Start")
		is_jumping = true
	else:
		if is_jumping:
			play_animation("Jump_Land")
			is_jumping = false
		elif input_dir.length() > 0:
			play_animation("Jog_Fwd")
		else:
			play_animation("Idle")

	move_and_slide()

func play_animation(anim_name: String):
	var anim_player = $AnimationLibrary_Godot_Standard/AnimationPlayer
	if anim_player.current_animation != anim_name and anim_player.has_animation(anim_name):
		anim_player.play(anim_name)
