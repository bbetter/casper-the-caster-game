extends Node2D

var cursor = load("res://assets/sight.png")
var _timer = null

var SpellPrefab = preload("res://scenes/Spell.tscn")

@onready var player = $Player
@onready var camera = $CursorCamera

@onready var HUD = get_node("HUD")

func _ready():
	
	Input.set_custom_mouse_cursor(
		cursor,
		Input.CURSOR_ARROW,
		Vector2(16, 16)
	)
	HUD.killed_count = player.killed_enemies
	HUD.hp = player.hp
	
	pass # Replace with function body.

func spawn_spell(position, direction):
	var spell = SpellPrefab.instantiate()
	add_child(spell)
	spell.start(position,direction)

func on_enemy_killed():
	var killedCount = player.increase_killed_count_and_get()
	HUD.killed_count = killedCount
	
func update_hp_count(new_hp):
	HUD.hp = new_hp

const MAX_CAMERA_DISTANCE := 50.0
const MAX_CAMERA_PERCENT := 0.1
const CAMERA_SPEED := 0.1


func _process(_delta):
		
	var viewport = get_viewport()
	var viewport_center = Vector2(viewport.size / 2.0)
	var mouse_position_in_viewport = viewport.get_mouse_position()
	var direction = (mouse_position_in_viewport - viewport_center).normalized()
	
	var percent = (direction / Vector2(viewport.size) * 2.0).length()
#
	var camera_position: Vector2
#
	if player == null or player.is_queued_for_deletion(): 
		return
#
	if percent < MAX_CAMERA_PERCENT:
		camera_position = player.global_position + direction * MAX_CAMERA_DISTANCE * (percent / MAX_CAMERA_PERCENT)
	else:
		camera_position = player.global_position + direction * MAX_CAMERA_DISTANCE
#
	camera.global_position = lerp(camera.global_position, camera_position, CAMERA_SPEED)
