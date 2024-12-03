extends Node2D

@onready var paddle_left = $PaddleLeft
@onready var paddle_right = $PaddleRight
@onready var ball = $Ball
@onready var score_left = $ScoreLeft
@onready var score_right = $ScoreRight
@onready var timer = $BallTimer
@onready var start = $Start
@onready var end = $End
@onready var end_text = $End/Label
var score_left_num = 0
var score_right_num = 0
var ai = true
var max_speed = 550
var max_ai_speed = 350

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start.visible == false:
		if Input.is_action_pressed("up_right"):
			paddle_right.position.y -= max_speed*delta
		if Input.is_action_pressed("down_right"):
			paddle_right.position.y += max_speed*delta
		if ai:
			var dist = paddle_left.position.y - ball.position.y
			if abs(dist) > max_ai_speed * delta:
				paddle_left.position.y -= max_ai_speed * delta * (dist / abs(dist))
			else:
				paddle_left.position.y -= dist
		else:
			if Input.is_action_pressed("up_left"):
				paddle_left.position.y -= 500*delta
				if paddle_left.position.y <= 66:
					paddle_left.position.y = 66
			if Input.is_action_pressed("down_left"):
				paddle_left.position.y += 500*delta
				if paddle_left.position.y >= 582:
					paddle_left.position.y = 582
		paddle_left.position.y = clamp(paddle_left.position.y, 66, 582)
		paddle_right.position.y = clamp(paddle_right.position.y, 66, 582)

func _on_ball_timer_timeout() -> void:
	ball.new_ball()

func _on_zone_left_body_entered(body: Node2D) -> void:
	score_right_num += 1
	score_right.text = str(score_right_num)
	if score_right_num < 10:
		timer.start()
	else:
		if ai:
			end_text.text = "You Win!"
		else:
			end_text.text = "Player 2 Wins!"
		end.show()
	
func _on_zone_right_body_entered(body: Node2D) -> void:
	score_left_num += 1
	score_left.text = str(score_left_num)
	if score_left_num < 10:
		timer.start()
	else:
		if ai:
			end_text.text = "You Lose!"
		else:
			end_text.text = "Player 1 Wins!"
		end.show()

func _on_single_pressed() -> void:
	ai = true
	start.hide()
	timer.start()
	paddle_left.position.y = 325
	paddle_right.position.y = 325

func _on_two_pressed() -> void:
	ai = false
	start.hide()
	timer.start()
	paddle_left.position.y = 325
	paddle_right.position.y = 325

func _on_again_pressed() -> void:
	start.show()
	score_left_num = 0
	score_right_num = 0
	score_left.text = "0"
	score_right.text = "0"
	end.hide()
