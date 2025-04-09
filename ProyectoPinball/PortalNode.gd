extends Control
class_name Portal

@export var outPortal : Portal
@export var is_blue_portal: bool
@export var existing_portal: bool = false

var currentBall: Ball 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	if (area.get_parent().get_parent() is Ball):
		print("touching area, ", name)
	
	if (not is_blue_portal):
		return
		
	if (existing_portal):
		existing_portal = false
		return
	
	if (area.get_parent().get_parent() is Ball):
		currentBall = area.get_parent().get_parent()
		currentBall.get_node("RigidBody2D").get_physics_material_override().bounce = 0
		
		# We need to change the position but also the velocity and angle.
		#print("velocity: ", velocity_to_angle(currentBall.get_node("RigidBody2D").linear_velocity))
		
		var ball_angle = velocity_to_angle(currentBall.get_node("RigidBody2D").linear_velocity)
		var linear_velocity = currentBall.get_node("RigidBody2D").linear_velocity
		#print("portal angle: ", rad2deg(get_portal_angle()))
		#print("ball angle: ", rad2deg(ball_angle))
		var portal_angle = get_portal_angle()
		print("angular momentum: ", rad2deg(get_angular_momentum(-portal_angle, linear_velocity)))
		var angular_momentum = get_angular_momentum(-portal_angle, linear_velocity)
		
		print("(PI/2-abs(angular_momentum), ", (PI-abs(angular_momentum)))
		print("angular momentum ", rad2deg(angular_momentum))
		currentBall.get_node("RigidBody2D").global_position.x = outPortal.global_position.x
		currentBall.get_node("RigidBody2D").global_position.y = outPortal.global_position.y
		currentBall.get_node("RigidBody2D").linear_velocity = Vector2(
			linear_velocity.length(), 0).rotated(outPortal.get_portal_angle() - (abs(angular_momentum))
			)
		outPortal.existing_portal = true
		
	pass # Replace with function body.
	
func rad2deg(radians: float) -> float:
	return radians * 180.0 / PI

func velocity_to_angle(velocity: Vector2) -> float:
	return atan2(velocity.y, velocity.x)
	
func invert_angle(angle_in_rads: float):
	return angle_in_rads + (PI / 2)
	
func get_portal_angle():
	var center = global_position
	var reference_point = $ReferencePoint.global_position  # Get the reference point position
	var direction = reference_point - center  # Compute direction vector
	return atan2(direction.y, direction.x)  # Convert to degrees

func get_angular_momentum(portal_angle: float, ball_direction: Vector2):
	var corr_ball_direction = -(ball_direction).rotated(portal_angle)
	var ball_angle =  velocity_to_angle(corr_ball_direction)
	#return (90 - portal_angle) + (90 - ball_angle)
	return ball_angle
