extends CharacterBody2D

const start_speed = 500
const acceleration = 50
var speed = 0
var dir = Vector2()
const max_y_vector = 0.6

func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../PaddleLeft" or collider == $"../PaddleRight":
			speed += acceleration
			dir = new_direction(collider)
		#if it hits a wall
		else:
			dir = dir.bounce(collision.get_normal())

func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var dist = ball_y - pad_y
	var new_dir := Vector2()
	
	if dir.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	new_dir.y = (dist / 66) * max_y_vector
	return new_dir.normalized()

func new_ball():
	position.x = 576
	position.y = randi_range(200, 448)
	speed = start_speed
	dir = random_direction()

func random_direction():
	var new_dir := Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
