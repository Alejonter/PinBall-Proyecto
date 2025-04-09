extends CharacterBody2D

@export var left_flipper := true
var rest_angle = 0.0
var active_angle = -40.0 if left_flipper else 40.0  # Mayor ángulo = más fuerza
var pressed := false
var return_delay := 0.08  # Tiempo que permanece "arriba"
var return_timer := 0.0

func _ready():
	rotation_degrees = rest_angle

func _physics_process(delta):
	if left_flipper and Input.is_action_just_pressed("flipper_left"):
		activate_flipper()
	elif not left_flipper and Input.is_action_just_pressed("flipper_right"):
		activate_flipper()

	# Temporizador para volver
	if pressed:
		return_timer -= delta
		if return_timer <= 0:
			pressed = false
			rotation_degrees = rest_angle

func activate_flipper():
	rotation_degrees = active_angle
	pressed = true
	return_timer = return_delay
