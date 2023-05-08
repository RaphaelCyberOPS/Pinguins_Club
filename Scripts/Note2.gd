extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	pass

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
