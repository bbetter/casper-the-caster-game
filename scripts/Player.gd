extends CharacterBody2D

const SpellPrefab = preload("res://scenes/Spell.tscn")
var is_spell_on_timeout = false

@export var speed: int = 100 # speed in pixels/sec
@export var hp: int = 3

var angle = 0
var killed_enemies = 0

func shoot():
	if(is_spell_on_timeout): 
		return
	
	is_spell_on_timeout = true
	var spell = SpellPrefab.instantiate()

	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout",Callable(self,"_on_Spell_Cooldown"))
	timer.set_wait_time(0.4)
	timer.set_one_shot(true) 
	timer.start()

	var direction = get_global_mouse_position() - global_position
	var direction_angle = get_global_mouse_position().angle_to(global_position)
	get_parent().add_child(spell)		
	spell.start(global_position,direction.rotated(direction_angle).normalized())
	print()

func _on_Spell_Cooldown():
	is_spell_on_timeout = false

func receive_damage():
	if (hp == 0):
		queue_free()
	else: 
		hp = hp - 1
	
	get_parent().update_hp_count(hp)

func increase_killed_count_and_get():
	killed_enemies = killed_enemies + 1
	return killed_enemies

func _physics_process(delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if Input.is_action_just_pressed("fire"):
		shoot()	
	
	if input_direction.x == 0 && input_direction.y == 0: 
		$AnimationPlayer.current_animation = "Down"		
	if input_direction.x > 0: 
		$AnimationPlayer.current_animation = "Right"
	if input_direction.x < 0: 
		$AnimationPlayer.current_animation = "Left"
	if input_direction.y > 0: 
		$AnimationPlayer.current_animation = "Down"		
	if input_direction.y < 0: 
			$AnimationPlayer.current_animation = "Up"
		
	velocity = input_direction * speed
	move_and_slide()
