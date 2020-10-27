# GodotProyectoGrupal: Rama Jorge
Avance del juego
 - Personaje puede moverse en las 4 direcciones principales
 - Personaje puede patear minerales y estos se mueven por unos segundos para luego detenerse
 
Actualización: 26 Oct
 - Los bloques de minerales ya interactuan entre sí. 
 - Un bloque puede romper otro si su nivel de dureza está 2 niveles o más por encima
 - Un bloque puede romperse al ser golpeado contra otro si su nivel de dureza está 2 niveles o más por debajo
 - Los bloques con un nivel de dureza cercano (por 1 de diferencia) no se rompen al chocar.
 - El personaje ya puede recoger polvo al acercarse a éste y presionando Z.
 
 Consideraciones importantes:
 - Hasta el momento se está utilizando 5 capas: Personaje, Mineral, Empuje, Polvo, Pared. Asignar su nombre correctamente.
 - Al momento de agregar un nuevo bloque a la escena SE DEBE configurar el nivel de dureza y el estado inicial (sólido o polvo) desde la interfaz de Godot.
 - Para que los dibujos se vean bien, se debe quitar el filtro que suaviza las imágenes en Godot.
 - La escena de mineral pertenece al grupo "Mineral".
