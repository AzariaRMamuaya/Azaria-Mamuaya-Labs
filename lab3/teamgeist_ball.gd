extends Sprite2D

@export var speed = 10

# Called when the node enters the scene tree for the first time
func _ready():
	print("I am a ball")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		position.x += speed
