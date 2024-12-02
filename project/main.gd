extends Node2D

@onready var paddle_left = $PaddleLeft
@onready var paddle_right = $PaddleRight
@onready var ball = $Ball
@onready var score_left = $ScoreLeft
@onready var score_right = $ScoreRight
@onready var timer = $BallTimer
var score_left_num = 0
var score_right_num = 0
var ai = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("up_right"):
		paddle_right.position.y -= 500*delta
		if paddle_right.position.y <= 66:
			paddle_right.position.y = 66
	if Input.is_action_pressed("down_right"):
		paddle_right.position.y += 500*delta
		if paddle_right.position.y >= 582:
			paddle_right.position.y = 582
			
	if Input.is_action_pressed("up_left") and ai == false:
		paddle_left.position.y -= 500*delta
		if paddle_left.position.y <= 66:
			paddle_left.position.y = 66
	if Input.is_action_pressed("down_left") and ai == false:
		paddle_left.position.y += 500*delta
		if paddle_left.position.y >= 582:
			paddle_left.position.y = 582

func _on_ball_timer_timeout() -> void:
	ball.new_ball()

func _on_zone_left_body_entered(body: Node2D) -> void:
	score_right_num += 1
	score_right.text = str(score_right_num)
	timer.start()
	
func _on_zone_right_body_entered(body: Node2D) -> void:
	score_left_num += 1
	score_left.text = str(score_left_num)
	timer.start()
