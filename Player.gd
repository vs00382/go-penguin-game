extends Area2D

signal hit
signal game_over

export var speed = 400
var screen_size
var score

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	#if Input.is_action_pressed("ui_down"):
		#velocity.y += 1
	#if Input.is_action_pressed("ui_up"):
		#velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite.animation = "up"
		#$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	#hide()  # Player disappears after being hit.
	#print(body.get_name())
	if "Seal" in body.get_name():
		emit_signal("game_over")
	#else: # if it's a fish
	emit_signal("hit")
	self.scale.x += 0.1
	self.scale.y += 0.05
	body.queue_free()
	#score += 1
	#$HUD.update_score(score)
	#$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
