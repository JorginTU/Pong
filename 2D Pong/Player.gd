extends KinematicBody2D

export var up = ""
export var down = ""
export var speed = 350
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed(up):
		direction.y -= 1
	if Input.is_action_pressed(down):
		direction.y += 1
	
	position.y += direction.y * speed * delta
	position.y = clamp(position.y, 30, (screen_size.y - 30))
