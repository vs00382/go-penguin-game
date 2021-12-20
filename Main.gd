extends Node

export (PackedScene) var Mob
export (PackedScene) var Seal
var score


func _ready():
	randomize()


func fish_score():
	#$ScoreTimer.stop()
	score += 1
	$HUD.update_score(score)
	#$MobTimer.stop()
	#$HUD.show_game_over()
	#get_tree().call_group("mobs", "queue_free")
	#$Music.stop()
	#$DeathSound.play()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$Player.scale.x = 1
	$Player.scale.y = 1
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	#$Music.play()


func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	var mob_number = rand_range(0, 1)
	
	if mob_number > 0.9:
		# Create a Mob instance and add it to the scene.
		# var mob = preload("res://Seal.gd").instance()
		var mob = Seal.instance()
		add_child(mob)
		# Set the mob's direction perpendicular to the path direction.
		#var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the mob's position to a random location.
		mob.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		#direction += rand_range(-PI / 4, PI / 4)
		#direction = 1
		mob.rotation = direction
		# Set the velocity (speed & direction).
		mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
		mob.linear_velocity = mob.linear_velocity.rotated(direction)
	else:
		# Create a Mob instance and add it to the scene.
		var mob = Mob.instance()
		add_child(mob)
		# Set the mob's direction perpendicular to the path direction.
		#var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
		# Set the mob's position to a random location.
		mob.position = $MobPath/MobSpawnLocation.position
		# Add some randomness to the direction.
		#direction += rand_range(-PI / 4, PI / 4)
		#direction = 1
		mob.rotation = direction
		# Set the velocity (speed & direction).
		mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
		mob.linear_velocity = mob.linear_velocity.rotated(direction)
	


func _on_StartTimer_timeout():
	$MobTimer.start()
	#$ScoreTimer.start()


func _on_Player_game_over():
	#$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	#get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	#$DeathSound.play()
	
	$Fart1.play()
