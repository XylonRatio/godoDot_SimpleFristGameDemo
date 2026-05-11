extends CharacterBody2D
@export var moveSpeed : float = 50
@export var animator : AnimatedSprite2D
var is_game_over : bool = false
@export var bullet_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		$run_audio.stop()
	elif not $run_audio.playing:
		$run_audio.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Input.get_vector('left','right','up','down')
	if not is_game_over:
		velocity = Input.get_vector('left','right','up','down') * moveSpeed
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()
		pass # func_end


func game_over() -> void:
	if not is_game_over:
		is_game_over = true
		animator.play("game over")
		$game_over_audio.play()
		$restar_timer.start() # 延迟3秒
		get_tree().current_scene.show_game_over()
		"""
		await get_tree().create_timer(3).timeout
		get_tree().reload_current_scene()
		"""
		pass # func end

func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	$fire_audio.play()
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6 , 6)
	get_tree().current_scene.add_child(bullet_node)
	pass # func end

func _on_restar_timer_timeout() -> void:
	get_tree().reload_current_scene()
	pass # func end
