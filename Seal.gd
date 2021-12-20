extends RigidBody2D

export var min_speed = 250
export var max_speed = 350


func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Seal_body_entered(body):
	hide()
	queue_free()
