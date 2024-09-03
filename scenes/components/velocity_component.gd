extends Node
class_name VelocityComponent

@export var max_speed: float = 40
@export var acceleration: float = 5

var velocity = Vector2.ZERO


func decelerate():
	accelerate_in_direction(Vector2.ZERO)


func flip_sprite(direction: Vector2, sprite: AnimatedSprite2D):
	if direction.x == 0:
		return
	
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true


func accelerate_in_direction(direction: Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
