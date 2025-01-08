extends Node

@export var ball_velocity = 1200;
var score = 0;
var lives = 3; 

var levelPaths = [
	'res://levels/level1bricks.tscn'
];

var brick_scene = preload("res://brick.tscn");

func _ready():
	#generate_bricks();
	load_level("level1bricks");
	start_new_round();

func load_level(levelName):
	var level = preload("res://levels/level1bricks.tscn").instantiate();
	$BrickArea.add_child(level);
	
	
#func generate_bricks():
	#generate_brick_row();
	#
#func generate_brick_row():
	#var brickAreaDimensions = $BrickArea/CollisionShape2D.get_shape().size;
	#
	##instantiate to get dimensions
	#var refBrick = brick_scene.instantiate();
	#var brickDimensions = refBrick.get_node("CollisionShape2D").get_shape().size;
	#brickDimensions.x = brickAreaDimensions.x / 5;
#
	#var brickPosition = 0;
	#for i in range(ceil(brickAreaDimensions.x / brickDimensions.x)):
		#var newBrick = brick_scene.instantiate();
		#var prefix = "brick";
		#newBrick.name = prefix + str(i)
		#
		#$BrickArea.add_child(newBrick);
		#newBrick.position.x = brickPosition;
		#brickPosition += brickDimensions.x
		#
		#newBrick.add_to_group('bricks');
	
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

func _on_ball_collided(col):
	if col.get_collider().is_in_group('bricks'):
		print('yup')
		col.get_collider().queue_free();
		update_score();
	

func _on_kill_zone_body_entered(body):
	update_lives();
	start_new_round();
