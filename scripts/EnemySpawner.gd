extends Node2D

var _timer = null
var rng = RandomNumberGenerator.new() 
var EnemyPrefab = preload("res://scenes/Enemy.tscn")

@onready var player = get_parent().get_node("Casper")

func _on_spawn_Cooldown():
	var enemy = EnemyPrefab.instantiate()

	enemy.position = Vector2(global_position.x - 100,global_position.y - 100)	
	get_parent().add_child(enemy)
	pass

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout",Callable(self,"_on_spawn_Cooldown"))
	_timer.set_wait_time(5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	
	pass # Replace with function body.
