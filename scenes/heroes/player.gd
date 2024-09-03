extends CharacterBody2D
class_name Player

@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO


func get_input_direction():
	return Input.get_vector("left", "right", "up", "down")

func _physics_process(_delta):
	direction = get_input_direction()

	velocity_component.flip_sprite(direction, sprite)
	velocity_component.accelerate_in_direction(direction.normalized())
	velocity_component.move(self)
