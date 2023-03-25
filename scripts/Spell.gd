extends CharacterBody2D

@export var speed: int = 300

var direction = Vector2()
var v = Vector2()

func start(pos, dir):
	global_position = pos
	direction = dir
	rotation = direction.angle()
#	rotation_degrees = angle_degrees


func _ready():
	set_as_top_level(true)
	
	pass

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if collision:
		if collision.get_collider().has_method("get_hit"):
			v = v.bounce(collision.get_normal())
			collision.get_collider().get_hit()
			queue_free()
		elif collision.collider.has_method("get_killed"):
			v = v.bounce(collision.get_normal())
			collision.get_collider().get_killed()
		
			queue_free()
			#TODO: schedule spawn in 0.1 sec  
			
			get_parent().spawn_spell(position, direction.rotated(-0.5))
			get_parent().spawn_spell(position, direction.rotated(0.5))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
