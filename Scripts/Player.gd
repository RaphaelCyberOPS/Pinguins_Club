
extends AnimatedSprite

export var speed = 500 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		move_local_x(speed * delta)
	elif Input.is_action_pressed("ui_left"):
		move_local_x(-speed * delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
