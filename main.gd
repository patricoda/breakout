extends Node

@export var ball_velocity = 1200;
var score = 0;
var lives = 3; 

var brick_scene = preload("res://brick.tscn")

func _ready():
	start_new_round();

func update_score():
	score += 1;
	update_score_display();
	
func update_score_display():
	$Score.text = str(score);	

func update_lives():
	lives -= 1;
	update_lives_display();
	
func update_lives_display():
	$Lives.text = str(lives);
	

func start_new_round():
	$Ball.position = Vector2($Arena.size.x / 2, $Arena.size.y / 2);
	$Ball.velocity = Vector2(randf_range(-300, 300), ball_velocity if randi_range(0, 1) == 1 else -ball_velocity);
	var brick = brick_scene.instantiate();
	$BrickArea.add_child(brick);
	brick.add_to_group('bricks');
	#todo: add bricks to the bricks group, lay them out

func _on_ball_collided(col):
	if col.get_collider().is_in_group('bricks'):
		print('yup')
		col.get_collider().queue_free();
		update_score();
	

func _on_kill_zone_body_entered(body):
	update_lives();
	start_new_round();
