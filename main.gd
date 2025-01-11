extends Node

@export var currentLevel = 0;
@export var ball_velocity = 1200;
var score = 0;
var lives = 3; 
var activeBricks = 0;

const levelPaths = [
	'res://levels/level1bricks.tscn'
];

var brick_scene = preload("res://brick.tscn");

func _ready():
	init_round();
	
func init_round():
	load_level();
	start_new_round();

func load_level():
	var level = load(levelPaths[currentLevel]).instantiate();
	$BrickArea.add_child(level);
	activeBricks = get_tree().get_nodes_in_group('bricks').size();
	
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
	$Ball.velocity = Vector2(randf_range(-300, 300), -ball_velocity);

func _on_ball_collided(col):
	if col.get_collider().is_in_group('bricks'):
		handle_brick_collision(col.get_collider());

func handle_brick_collision(brick):
	brick.destroy();
	activeBricks -= 1;
	update_score();
	
	if(activeBricks == 0):
		handle_level_complete();
	
func handle_level_complete():
	init_round();

func _on_kill_zone_body_entered(body):
	update_lives();
	start_new_round();
