extends Node2D

func _ready():
	var rand = RandomNumberGenerator.new()
	var objetscene = load("res://Scenes/Objets.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	for i in range(0,10):
		var objet = objetscene.instance()
		rand.randomize()
		var x = rand.randf_range(0,screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0,screen_size.y)
		objet.position.y = y
		objet.position.x = x
		add_child(objet)
