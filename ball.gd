extends CharacterBody2D

signal collided;

var speed = 0;

func adjust_speed(increment):
	speed += increment;
	velocity = velocity.normalized() * speed
 
func _physics_process(delta):
	var col = move_and_collide(velocity * delta)

	if col:
		if col.get_collider().name == 'Paddle':
			velocity = global_position - col.get_collider().global_position 
			velocity = velocity.normalized() * speed
		else:
			var normal := col.get_normal()
			velocity = velocity.bounce(normal)
			
		collided.emit(col);
		
