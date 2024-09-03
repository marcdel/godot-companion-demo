extends CharacterBody2D
class_name Priest

@export var max_speed = 100
@export var acceleration = 5

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var formation_component: FormationComponent = $FormationComponent


func _ready() -> void:
	max_speed = randi_range(50, 100)
	acceleration = randi_range(2, 5)


func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player") as Player
	if player == null:
		return

	var angle = formation_component.get_angle_for_position(player)
	$Label.text = "Angle: %s" % rad_to_deg(angle)
	
	var distance = formation_component.get_direction_to_leader(player)
	var direction = distance.normalized()

	if abs(distance) < Vector2.ONE:
		return

	velocity_component.flip_sprite(direction, sprite)
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)
