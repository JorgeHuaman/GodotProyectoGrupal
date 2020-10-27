extends KinematicBody2D

#Direccion a donde mira
var direccion = Vector2(0,0)
#Si está o no moviendose
var en_movimiento = false
#Vector de movimiento
var movimiento = Vector2(0,0)
#Velocidad de movimiento
var velocidad = 120
#Para detectar si está empujado y no se pueda mover
var esta_empujando = false

#Maquina de estados
enum {IDLE, WALK, PUSH}
var estado
var animacion_actual
var animacion_nueva

var polvo_fijado = null

func _ready():
	#Animación Inicial
	$AnimatedSprite.animation = "IdleDown"
	_transicion_a(IDLE)
	
func _physics_process(delta):
	
	#Maquina de estados
	if animacion_actual != animacion_nueva:
		animacion_actual = animacion_nueva
		$AnimatedSprite.play(animacion_actual)
	
	#Para el movimiento
	movimiento = Vector2(0,0)
	
	if Input.is_action_pressed("ui_down") and (direccion == Vector2(0,1) or en_movimiento == false) and esta_empujando == false:
		movimiento.y += 1
		direccion = Vector2(0,1)
		en_movimiento = true
	elif Input.is_action_pressed("ui_up") and (direccion == Vector2(0,-1) or en_movimiento == false) and esta_empujando == false:
		movimiento.y -= 1
		direccion = Vector2(0,-1)
		en_movimiento = true
	elif Input.is_action_pressed("ui_left") and (direccion == Vector2(-1,0) or en_movimiento == false) and esta_empujando == false:
		movimiento.x -= 1
		direccion = Vector2(-1,0)
		en_movimiento = true
	elif Input.is_action_pressed("ui_right") and (direccion == Vector2(1,0) or en_movimiento == false) and esta_empujando == false:
		movimiento.x += 1
		direccion = Vector2(1,0)
		en_movimiento = true
	else:
		en_movimiento = false
		
	movimiento = movimiento.normalized()*velocidad
	move_and_slide(movimiento,Vector2(0,0))
	
	#Para asegurarse que está mirando a la dirección correcta puedes usar este print
	#print(direccion)
		
	if estado == IDLE and en_movimiento == true:
		_transicion_a(WALK)
		
	if estado == WALK and en_movimiento == false:
		_transicion_a(IDLE)
		
	if estado in [IDLE,WALK] and Input.is_action_just_pressed("ui_accept"):
		_transicion_a(PUSH)
		_push()
		esta_empujando = true
		yield($AnimatedSprite, "animation_finished")
		esta_empujando = false
		_nopush()
		_transicion_a(IDLE)

#Activar empujar
func _push():
	if direccion == Vector2(0,1):
		$AreaEmpujeAbajo/Abajo.disabled = false
	elif direccion == Vector2(0,-1):
		$AreaEmpujeArriba/Arriba.disabled = false
	elif direccion == Vector2(-1,0):
		$AreaEmpujeIzquierda/Izquierda.disabled = false
	elif direccion == Vector2(1,0):
		$AreaEmpujeDerecha/Derecha.disabled = false
		
#Desactivar empujar
func _nopush():
		$AreaEmpujeAbajo/Abajo.disabled = true
		$AreaEmpujeArriba/Arriba.disabled = true
		$AreaEmpujeIzquierda/Izquierda.disabled = true
		$AreaEmpujeDerecha/Derecha.disabled = true

#Maquina de estados
func _transicion_a(nuevo_estado):
	estado = nuevo_estado
	match estado:
		IDLE:
			if direccion == Vector2(0,1):
				animacion_nueva = "IdleDown"
			elif direccion == Vector2(0,-1):
				animacion_nueva = "IdleUp"
			elif direccion == Vector2(-1,0):
				animacion_nueva = "IdleLeft"
			elif direccion == Vector2(1,0):
				animacion_nueva = "IdleRight"
		WALK:
			if direccion == Vector2(0,1):
				animacion_nueva = "WalkDown"
			elif direccion == Vector2(0,-1):
				animacion_nueva = "WalkUp"
			elif direccion == Vector2(-1,0):
				animacion_nueva = "WalkLeft"
			elif direccion == Vector2(1,0):
				animacion_nueva = "WalkRight"
		PUSH:
			if direccion == Vector2(0,1):
				animacion_nueva = "PushDown"
			elif direccion == Vector2(0,-1):
				animacion_nueva = "PushUp"
			elif direccion == Vector2(-1,0):
				animacion_nueva = "PushLeft"
			elif direccion == Vector2(1,0):
				animacion_nueva = "PushRight"

#Función para detectar el polvo de mineral cuando está cerca
func _on_AreaRecogePolvo_body_entered(body):
	if body.is_in_group("Mineral"):
		if body.solido == false:
			polvo_fijado = body
			
#Función para para dejar de detectar el polvo de mineral cuando no está cerca
func _on_AreaRecogePolvo_body_exited(body):
	if body.is_in_group("Mineral"):
		if body.solido == false:
			polvo_fijado = null
			
#Función para recoger mineral
func _input(event):
	if event.is_action_pressed("ui_z"):
		if polvo_fijado != null:
			polvo_fijado.queue_free()
		

