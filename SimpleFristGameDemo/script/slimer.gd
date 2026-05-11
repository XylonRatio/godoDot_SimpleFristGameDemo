extends Area2D

@export var slime_speed : float = -50
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # func end


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_dead:
		position += Vector2(slime_speed,0) * delta
	if position.x < -270:
		queue_free()
	pass # func end

#史莱姆接触玩家，游戏结束
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not is_dead:
		body.game_over()
		pass
	pass # func end

#子弹击中史莱姆，史莱姆死掉的啦
func _on_bullet_hit(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		$AnimatedSprite2D.play("die")
		$AudioStreamPlayer2D.play()
		is_dead = true
		area.queue_free()
		get_tree().current_scene.score += 1
		await get_tree().create_timer(0.6).timeout #等0.6s来让死亡动画和音效播放完
		queue_free()
		pass
	pass # func end
