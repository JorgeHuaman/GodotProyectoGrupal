extends KinematicBody2D

#Variables para controlar la dureza y el estado desde la interfaz
export (int) var dureza
export (bool) var solido

var movimiento = Vector2(0,0)
var velocidad = 240
var direccion

#var lista_minerales = ["Talco 1","Yeso 2","Calcita 3","Fluorita 4","Apatita 5","Ortoclasas 6","Cuarzo 7","Topacio 8","Corindon 9","Diamante 10"]

#Arriba, abajo, izquierda, derecha
var pared_mineral = [0,0,0,0]

func _ready():
	_colocar_nombre()
	_seleccionar_animacion_solidez()
	set_physics_process(false)
	#mostrar la imagen del mineral
	if dureza >= 1 or dureza <= 10:
		$AnimatedSprite.frame = dureza - 1
	else:
		print("un mineral no tiene un valor asignado válido")

func _physics_process(delta):
		
	#Movimiento cuando es empujado
	movimiento = (movimiento + direccion).normalized()*velocidad
	move_and_slide(movimiento,Vector2(0,0))

#Activar movimiento cuando es empujado
func _on_AreaDeteccionEmpuje_area_entered(area):
	
	if area.name == "AreaEmpujeArriba" and pared_mineral[0] == 0 and solido == true:
		#print("se detecto un empuje por abajo")
		direccion = Vector2(0,-1)
		z_index = 3
		set_physics_process(true)

	elif area.name == "AreaEmpujeAbajo" and pared_mineral[1] == 0 and solido == true:
		#print("se detecto un empuje por arriba")
		direccion = Vector2(0,1)
		z_index = 3
		set_physics_process(true)
		
	elif area.name == "AreaEmpujeIzquierda" and pared_mineral[2] == 0 and solido == true:
		#print("se detecto un empuje por derecha")
		direccion = Vector2(-1,0)
		z_index = 3
		set_physics_process(true)
		
	elif area.name == "AreaEmpujeDerecha" and pared_mineral[3] == 0 and solido == true:
		#print("se detecto un empuje por izquierda")
		direccion = Vector2(1,0)
		z_index = 3
		set_physics_process(true)
		
func _on_AreaDeteccionSuperior_body_entered(body):
	if body.name == "Pared":
		pared_mineral[0] = 1
		#print("Detectó una pared por arriba")
		if direccion == Vector2(0,-1):
			_detenerse()
	elif body.is_in_group("Mineral") and direccion == Vector2(0,-1):
		if dureza - 1 > body.dureza:
			body._convertirse_polvo()
		else:
			_detenerse()
			pared_mineral[0] = 1
			if dureza < body.dureza -1:
				_convertirse_polvo()
			
func _on_AreaDeteccionSuperior_body_exited(body):
	if body.name == "Pared" or body.is_in_group("Mineral"):
		#print("Ya no detecta una pared por arriba")
		pared_mineral[0] = 0

func _on_AreaDeteccionInferior_body_entered(body):
	if body.name == "Pared":
		pared_mineral[1] = 1
		#print("Detectó una pared por abajo")
		if direccion == Vector2(0,1):
			_detenerse()
	elif body.is_in_group("Mineral") and direccion == Vector2(0,1):
		if dureza - 1 > body.dureza:
			body._convertirse_polvo()
		else:
			_detenerse()
			pared_mineral[1] = 1
			if dureza < body.dureza -1:
				_convertirse_polvo()
			
func _on_AreaDeteccionInferior_body_exited(body):
	if body.name == "Pared" or body.is_in_group("Mineral"):
		#print("Ya no detecta una pared por abajo")
		pared_mineral[1] = 0

func _on_AreaDeteccionIzquierdo_body_entered(body):
	if body.name == "Pared":
		pared_mineral[2] = 1
		#print("Detectó una pared por izquierda")
		if direccion == Vector2(-1,0):
			_detenerse()
	elif body.is_in_group("Mineral") and direccion == Vector2(-1,0):
		if dureza - 1 > body.dureza:
			body._convertirse_polvo()
		else:
			_detenerse()
			pared_mineral[2] = 1
			if dureza < body.dureza -1:
				_convertirse_polvo()

func _on_AreaDeteccionIzquierdo_body_exited(body):
	if body.name == "Pared" or body.is_in_group("Mineral"):
		#print("Ya no detecta una pared por izquierda")
		pared_mineral[2] = 0

func _on_AreaDeteccionDerecho_body_entered(body):
	if body.name == "Pared":
		pared_mineral[3] = 1
		#print("Detectó una pared por derecha")
		if direccion == Vector2(1,0):
			_detenerse()
	elif body.is_in_group("Mineral") and direccion == Vector2(1,0):
		if dureza - 1 > body.dureza:
			body._convertirse_polvo()
		else:
			_detenerse()
			pared_mineral[3] = 1
			if dureza < body.dureza -1:
				_convertirse_polvo()
			
func _on_AreaDeteccionDerecho_body_exited(body):
	if body.name == "Pared" or body.is_in_group("Mineral"):
		#print("Ya no detecta una pared por derecha")
		pared_mineral[3] = 0

func _convertirse_polvo():
	solido = false
	$AnimatedSprite.animation = "Polvo"
	$AnimatedSprite.frame = dureza - 1
	self.set_collision_mask_bit(1,false)
	self.set_collision_layer_bit(1,false)
	z_index = 1

func _detenerse():
	set_physics_process(false)
	movimiento = Vector2(0,0)
	z_index = 2

func _seleccionar_animacion_solidez():
	if solido == true:
		$AnimatedSprite.animation = "Solido"
		self.set_collision_layer_bit(1,true)
		z_index = 2
	else:
		$AnimatedSprite.animation = "Polvo"
		self.set_collision_mask_bit(1,false)
		self.set_collision_layer_bit(1,false)
		z_index = 1
		
func _colocar_nombre():
	$Label.text = str(dureza)
