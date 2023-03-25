extends CharacterBody2D

@export var speed = 60
@export var hp = 2

@onready var HighlightMaterial = preload("res://shaders/enemy_highlight_material.tres")
@onready var player: CharacterBody2D = get_parent().get_node("Player")
@onready var map: TileMap = get_parent().get_node("Map")
@onready var agent: NavigationAgent2D = $NavAgent

func _ready():
	agent.set_navigation_map(map)

func _physics_process(delta):		
	agent.target_position = player.global_position
	
	var dir = agent.get_next_path_position().normalized()
	
	velocity = dir.normalized() * speed * delta
		
	rotate(get_angle_to(dir))
	look_at(dir)
	
	var collision = move_and_collide(velocity)

	if(collision):
		print(collision.get_collider())
		if collision.get_collider().has_method("receive_damage"):
			collision.get_collider().receive_damage()
			queue_free()

func get_hit():
	hp = hp - 1
	get_node("AnimationPlayer").current_animation = "Damaged"
	if hp == 0: 
		get_parent().on_enemy_killed()
		queue_free()
