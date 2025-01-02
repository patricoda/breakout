extends CharacterBody2D

@export var speed = 400;
@export var leftInput = '';
@export var rightInput = '';
	
func _physics_process(delta):
	if Input.is_action_just_pressed(leftInput):
		velocity.x = -speed
		
	if Input.is_action_just_pressed(rightInput):
		velocity.x = speed

	move_and_collide(velocity * delta)
