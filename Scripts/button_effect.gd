# Le but de se script est de d'afficher des effets visuels et sonores impactant sur le node "objet" qui le contiens
# quand la note MIDI qui lui correspond est jouée

extends Control


func effet_objet():
	# Une couleur dans Godot peut être décris en code de cette façon: Color(rouge,vert,bleu,opacité)
	# chacun de ces paramêtres est un float qui va de 0 (absent) à 1 (complètement présent)
	# presque tous les nodes de Godot ont par défaut un paramêtre "modulate" (que vous pouvez trouvez dans l'inspecteur dans "Visibility")
	# "modulate" prends en paramètre une "Color"
	# Pour l'instant le paramêtre "modulate" du node texture enfant (texture = image) est à "1,1,1,0.2"
	# Ca signifie que les couleurs de la texture sont les mêmes mais que l'opacité est à 0.2 (= 20%)
	# La ligne suivante passe l'opacité à 1 (= 100%)
	$"Texture".modulate = Color( 1, 1, 1, 1 )
	
	# Une tween ! Un outil bien pratique pour faire pleins d'animations
	# Une tween est une fonction présente dans presque tous les moteurs de jeu
	# Ca permet de changer une variable d'une valeure vers une autre en un temps donné
	# D'abord on crée la tween avec la fonction de Godot "create_tween" et on la stock dans une variable:
	var tween = create_tween()
	# puis on active la tween en définissant ces propriétées
	# Voici les propriété attendu:
	# (le_node_contenant_, le_nom_du_parametre_a_changer, valeure_finale_désirée, en_combien_de_secondes)
	# Le temps (le dernier paramètre) doit être en float. Moi j'ai mis 1.1, donc 1,1 seconde
	tween.tween_property($"Texture", "modulate", Color(1,1,1,0.2), 1.1)
	# Et voilà ! La tween s'est activée. La texture va passer d'une opacité 100% à 20% en 1,1 seconde
	
	# J'ai paramétré un système de particules pour qu'il emmette des genres de confettis
	# Pour le lancer j'ai juste à activer sa fonction "restart" fournie par Godot:
	$"Particules".restart()
	
	# J'ai aussi paramétré un audio_stream_player auquel j'ai déjà ajouté un son depuis l'inspecteur
	# Pour le jouer, j'appelle sa fonction "play" fournie par Godot:
	$"audio_stream_player".play()
