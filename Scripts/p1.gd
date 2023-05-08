extends Area2D
signal hit


export var speed = 500
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	OS.open_midi_inputs( )
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	set_position(position)

func _on_Player_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false



func _on_Player2_body_entered(body):
	body.queue_free()




# efface ci-dessous si marche
func _input(event):
	if event is InputEventMIDI:
		print(event.pitch)
		
		traiter_evenement_midi(event)

func traiter_evenement_midi(event_midi):
	var velocity = Vector2.ZERO
	if event_midi.message == MIDI_MESSAGE_NOTE_ON:
		print("NOTE_ON")
		if event_midi.pitch == 48:
			velocity.x += 1
		elif event_midi.pitch == 50:
			velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * 0.17
	position.x = clamp(position.x, 0, screen_size.x)
	set_position(position)


