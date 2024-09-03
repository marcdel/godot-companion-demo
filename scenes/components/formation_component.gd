extends Node
class_name FormationComponent

enum POSITION {TOP, BOTTOM, FRONT, REAR, FRONT_TOP, FRONT_BOTTOM, REAR_TOP, REAR_BOTTOM}

@export var formation_position: POSITION

var leader_last_direction: Vector2 = Vector2.ONE
var position_map: Dictionary


func _ready() -> void:
	assert(formation_position != null)
	set_random_angle_for_position()


# https://i.sstatic.net/5zOW8.gif
func set_random_angle_for_position():
	position_map[POSITION.TOP] = deg_to_rad(randi_range(80, 100))
	position_map[POSITION.BOTTOM] = deg_to_rad(randi_range(260, 280))
	
	position_map[POSITION.REAR] = deg_to_rad(randi_range(160, 200))
	position_map[POSITION.REAR_TOP] = deg_to_rad(randi_range(210, 240))
	position_map[POSITION.REAR_BOTTOM] = deg_to_rad(randi_range(120, 150))

	position_map[POSITION.FRONT] = deg_to_rad(0)
	position_map[POSITION.FRONT_TOP] = deg_to_rad(randi_range(300, 330))
	position_map[POSITION.FRONT_BOTTOM] = deg_to_rad(randi_range(30, 60))


func get_direction_to_leader(party_leader: Player):
	var angle = get_angle_for_position(party_leader)
	var radius = 150
	var near_leader = party_leader.global_position + Vector2.RIGHT.rotated(angle)*radius
	var distance = (near_leader - (owner as Node2D).global_position)
	return distance


func get_angle_for_position(party_leader: Player):
	var leader_current_direction = party_leader.get_input_direction()
	if leader_current_direction.x != 0:
		#print("leader_last_direction: %s" % leader_last_direction)
		#print("leader_current_direction: %s" % leader_current_direction)
	
		leader_last_direction = leader_current_direction
		if leader_current_direction != leader_last_direction:
			set_random_angle_for_position()

	var position: POSITION = formation_position

	if leader_last_direction.x < 0:
		match formation_position:
			POSITION.REAR:
				position = POSITION.FRONT
			POSITION.REAR_TOP:
				position = POSITION.FRONT_TOP
			POSITION.REAR_BOTTOM:
				position = POSITION.FRONT_BOTTOM

	return position_map[position]
