extends Node

var speed = 150
var acceleration = 1.07
var direction = Vector2(0,0)
var angle = 0.0
var p1_points = 0
var p2_points = 0
var turn = true

func _ready():
	$UI.connect("start", self, "started")
	var start_turn = randi() % 2
	
	match start_turn:
		0:
			turn = true
		1:
			turn = false

func _physics_process(delta):
	direction = direction.normalized()
	$Ball.position += direction * speed * delta

func started():
	roll_ball()

func roll_ball():
	if turn:
		direction.x -= 1
	else:
		direction.x += 1

func scored():
	direction = Vector2.ZERO
	$Ball.position = $Center.position
	$"Player 1".position.y = $Center.position.y
	$"Player 2".position.y = $Center.position.y
	speed = 150

func _on_Ball_body_entered(body):
	angle = float(rand_range(0,13)) / 10
	direction.y = angle
	direction.x = direction.x * -1
	speed = speed * acceleration


func _on_Walls_area_entered(area):
	direction.y = direction.y * -1


func _on_Goal_1_area_entered(area):
	p2_points += 1
	scored()
	turn = true
	$UI.change_score(p1_points, p2_points)
	$Timer_restart.start()



func _on_Goal_2_area_entered(area):
	p1_points += 1
	scored()
	turn = false
	$UI.change_score(p1_points, p2_points)
	$Timer_restart.start()


func _on_Timer_restart_timeout():
	roll_ball()
