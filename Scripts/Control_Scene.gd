# Je suis un commentaire ! Je n'ai pas d'effet sur l'execution du code
# Quand vous aurez lu tous mes commentaires, vous pouvez les effacer, ce script n'a que ~35 lignes de vrai code

# Cette ligne permet à Godot de savoir de quelle classe Global Godot votre fichier script hérite
extends Control

# Ici j'ai créé la déclaration d'une variable nommée "message_de_bienvenu" qui comprends la string "Bonjour!"
var message_de_bienvenu = "Bonjour!"

# La fonction _ready est une fonction de Godot appelée automatiquement lorsque le node entre dans le scène pour la première fois (souvent au début du jeu)
# Généralement, si le nom d'une fonction commence par un underscore, c'est une fonction qui appartient à Godot, et qui est appelée automatiquement dans certaines situations
func _ready():
	# print("quelque chose") est une fonction Godot  qui permet d'afficher des messages dans la console
	# la console de Godot est accéssible en cliquant sur "Output" ("Sortie") en bas de votre écran
	# Ici j'affiche dans la console le contenu de la variable "message_de_bienvenu" ("Bonjour!")
	print(message_de_bienvenu)
	
	# Sans cette ligne, Godot ne lira pas le MIDI
	OS.open_midi_inputs( )
	
	# Une boucle qui liste et affiche tous les appareil MIDI connecté à l'ordinateur
	# "get_connected_midi_inputs" est une fonction de Godot qui appartient à OS (qui est aussi une variable de Godot)
	for current_midi_input in OS.get_connected_midi_inputs( ):
		print(current_midi_input)


# "_input" est appelée automatiquement chaque fois qu'un événement d'entrée (input) est détecté dans la scène de jeu
# "event" est ce que Godot envoie en paramêtre de "_input", une variable contenant toutes les infos de l'événement
# Plus d'infos ici: https://docs.godotengine.org/fr/stable/tutorials/inputs/input_examples.html
func _input(event):
	# Si cet événement est du MIDI:
	if event is InputEventMIDI:
		# si l'événement est du MIDI, il contiendra toutes les informations classique du MIDI (message, pitch, instrument, etc.)
		# Pour plus d'info sur le MIDI, voir notre cours "2 - IoT - Musique éléctonique et MIDI" 
		# Donc si on print event.pitch, on affichera le code de la note MIDI:
		print(event.pitch)
		
		# Ici j'appelle ma fonction "traiter_evenement_midi" en lui passant l'event en paramêtre.
		# Le détail de la fonction se trouve plus bas
		traiter_evenement_midi(event)
		
		afficher_note(event.pitch)

func traiter_evenement_midi(event_midi):
	# Si la varible "message" contenu dans la variable "event" = "MIDI_MESSAGE_NOTE_ON" (voir "NOTE ON" dans notre cours)
	# En d'autres termes: "si l'événement midi a été déclenchée par une note qui vient d'être pressée"
	if event_midi.message == MIDI_MESSAGE_NOTE_ON:
		print("NOTE_ON")
		# "Si la note de l'événement MIDI est 48"
		if event_midi.pitch == 48:
			# Appeler ma fonctionner "activer_objet" en lui passant 48 en paramètres
			# voir le détail de la fonction plus bas
			activer_objet(48)
		# "Sinon si la note de l'événement MIDI est 50"
		elif event_midi.pitch == 50:
			# Pareil avec 50 en paramètres
			activer_objet(50)

	# "sinon si l'événement midi a été déclenchée par une note qui vient d'être relachée"
	elif event_midi.message == MIDI_MESSAGE_NOTE_OFF:
		print("NOTE_OFF")
	
	# "sinon si l'événement midi a été déclenchée par un changement de pitch"
	elif event_midi.message == MIDI_MESSAGE_PITCH_BEND:
		print("PITCH_BEND")
		
		# Pour l'instant event_midi.pitch est un int, faisons-en un float!
		var note_float = event_midi.pitch as float
		
		# Le problème est que le pitch bend (ici contenu dans "event_midi.pitch" est un chiffre entre 0 et 16384. Pas très pratique pour travailler...
		# C'est souvent plus pratique de travailler avec un chiffre entre -1 et 1
		# Dans la ligne suivante, je transforme event_midi.pitch (qui est maintenant un float) en un chiffre entre -1 et 1
		var note_float_reduite = note_float / 8192.0 - 1.0
		# On aurait aussi pu raccourcir toutes les lignes précédentes en écrivant:
		print( float(event_midi.pitch) / 8192.0 - 1.0 )
		
		# Et pourquoi j'ai fais tout ça ?
		# Pour que le pitch bend soit représenté sous forme d'une barre de progression qui est dans la scène
		# Ici j'accède donc à la valeure de remplissage de la barre de progrès (value) et lui donne notre variable "note_float_reduite"
		$"Conteneur_pitch_bend/ProgressBar".value = note_float_reduite
		# Pour accéder aux propriétés ou au script d'un node "enfant" du node dans lequel notre script s'execute,
		# on peut le chercher avec: $"le_chemin_vers_le_node"
		# on peut aussi écrire get_node("le_chemin_vers_le_node") ou $le_chemin_vers_le_node (sans les guillemets)


# Fonction qui active du son, des particules et un effet visuel de l'objet A ou B selon la note jouée (ici 48 ou 50)
func activer_objet(note):
	if note == 48:
		# On va chercher le node enfant "Conteneur_Objet_A" et on active la fonction "effet_objet" qu'il contient
		# la fonction "effet_objet" se trouve dans le script attaché à "Conteneur_Objet_A"
		$"Conteneur_Objet_A".effet_objet()
	if note == 50:
		# Pareil pour "Conteneur_Objet_B" 
		$"Conteneur_Objet_B".effet_objet()


# Fonction qui change le texte du node "Note_Jouée" en affichant le code MIDI de la note
func afficher_note(note):
	# On récupère un node de type "Label" et on attribue à sa valeure "text" la note MIDI
	# Comme la valeure "text" n'accepte que les string et que event.pitch est un int, on utilise "as String" pour changer le type de la varible
	$"Conteneur_note_jouée/Note_jouée".text = note as String


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	

