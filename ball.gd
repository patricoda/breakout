extends CharacterBody2D

signal collided;

func _physics_process(delta):
	var col = move_and_collide(velocity * delta)

	if col:
		if col.get_collider().name == 'Paddle':
			velocity = global_position - col.get_collider().global_position 
			#todo: refer to ball speed from main class
			velocity = velocity.normalized() * 1200
		else:
			var normal := col.get_normal()
			velocity = velocity.bounce(normal)
			
		collided.emit(col);
		
