extends Node

export(PackedScene) var mob_scene
var score


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	
		$ScoreTimer.stop()
		$MobTimer.stop()
		$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_MobTimer_timeout():
	
	#choose a random location on Path2D
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	#create a mob instance and add it to the scene.
	var mob = mob_scene.instance()
	add_child(mob)
	
	#set the mob's direction perpendicular to the path direction.
	#Godot using radians not degrees - PI is about a half turn in radians - 
	#this is setting it perpendicular by setting it to rotate ~ quarter turn

	
	var direction = mob_spawn_location.rotation + PI / 2
	
	#set the mob's position to a random location 
	#note we're using the var created above
	
	mob.position = mob_spawn_location.position
	
	#add some randomness to this direction business
	#note we're using the var created above 
	#As before this is in radians
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#choose velocity
	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
