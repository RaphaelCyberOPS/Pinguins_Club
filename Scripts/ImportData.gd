extends Node

var item_data

func _ready():
		
	var test = File.new()
	test.open("res://Data/Disco.json", File.READ)
	var tes_dict = parse_json(test.get_as_text())
#	print(tes_dict["tracks"])
	for note in tes_dict.tracks[0].notes:
		print(note.time)
