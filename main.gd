extends Node

@export var currentLevel = 0;
@export var ball_speed = 600;
@export var ball_speed_increment = 50;

var initialLives = 3;
var score = 0;
var lives = 0; 
var activeBricks = 0;

const levelPaths = [
	'res://levels/level1bricks.tscn'
];

var brick_scene = preload("res://brick.tscn");

func _ready():
	init_round();
	
func init_round():
	$Message.hide();
	load_level();
	set_initial_values();
	start_round();
	
func set_initial_values():
	update_score(0);
	update_lives(initialLives);

func load_level():
	clear_brick_area();
	
	var level = load(levelPaths[currentLevel]).instantiate();
	$BrickArea.add_child(level);
	
	activeBricks = get_tree().get_nodes_in_group('bricks').size();
	
func clear_brick_area():
	for child in $BrickArea.get_children():
		$BrickArea.remove_child(child)
		child.queue_free()
	
	
	
func update_score(newScore):
	score = newScore;
	update_score_display();
	
func update_score_display():
	$Score.text = "Score: " + str(score);	

func update_lives(lifeCount):
	lives = lifeCount;
	update_lives_display();
	
func update_lives_display():
	$Lives.text = "Lives: " + str(lives);
	
func start_round():
	$Ball.speed = ball_speed
	$Ball.position = Vector2($Arena.size.x / 2, $Arena.size.y / 2);
	$Ball.velocity = Vector2(randf_range(-300, 300), -ball_speed);
	$Ball/CollisionShape2D.disabled = false;
	$Ball.show();

func _on_ball_collided(col):
	if col.get_collider().is_in_group('bricks'):
		handle_brick_collision(col.get_collider());

func handle_brick_collision(brick):
	brick.destroy();
	activeBricks -= 1;
	update_score(score + 1);
	
	if(activeBricks == 0):
		handle_level_complete();
	else:
		$Ball.adjust_speed(ball_speed_increment);

func handle_life_lost():
	update_lives(lives - 1);
	
	if(lives == 0):
		handle_game_over();
	else:
		start_round();
		
func handle_level_complete():
	handle_level_end("Level complete!");
	
func handle_game_over():
	handle_level_end("Game over!");
	
func handle_level_end(message):
	$Ball.hide()
	$Ball/CollisionShape2D.disabled = true;
	
	display_message(message);
	await get_tree().create_timer(2.0).timeout
	init_round();
	
func display_message(message):
	$Message.show();
	$Message.text = message;
	
func _on_kill_zone_body_entered(body):
	handle_life_lost();
	
