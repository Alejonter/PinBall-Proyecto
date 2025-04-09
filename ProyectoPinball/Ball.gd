extends Control
class_name Ball

@export var speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport().size.x / 2
	#get_node("CharacterBody2D").velocity = Vector2(1, 0) * speed;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass
