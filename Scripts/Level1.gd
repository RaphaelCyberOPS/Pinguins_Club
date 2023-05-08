extends Node

var audio_player
var music_length

export var num_objects = 10
export var object_type = preload("res://Scenes/Objets.tscn")
export var spawn_range = Rect2(-200, -200, 400, 400)

var rng = RandomNumberGenerator.new()

func _ready():
	audio_player = $AudioStreamPlayer
	audio_player.connect("finished", self, "on_music_finished")
	audio_player.play()
	music_length = audio_player.get_stream_length()

	load_obstacle_data()
	$Player.connect("mort", self, "changer_scene")

func load_obstacle_data():
	var file = File.new()

func _process(delta):
	if get_child_count() < num_objects:
		var object = object_type.instance()
		var position = Vector2(rng.randi_range(spawn_range.position.x, spawn_range.size.x),
							   rng.randi_range(spawn_range.position.y, spawn_range.size.y))
		object.position = position
		add_child(object)

func on_music_finished():
	get_tree().change_scene("res://Scenes/Select_Level.tscn")

func changer_scene():
	get_tree().change_scene("res://Scenes/Menu.tscn")
