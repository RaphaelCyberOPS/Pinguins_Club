extends CollisionShape2D



var speed = 500

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		move_local_x(speed * delta)
	elif Input.is_action_pressed("ui_left"):
		move_local_x(-speed * delta)

func _ready_hitbox():
	var area = $Area2D
	area.connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body.has_method("get_score"):
		var score = body.get_score()
		# Ajouter le score au joueur ou faire autre chose
