extends KinematicBody2D

var movimiento = Vector2(0,0)
var velocidad = 240
var direccion

func _ready():
	set_physics_process(false)

func _physics_process(delta):
		
	#Movimiento cuando es empujado
	movimiento = (movimiento + direccion).normalized()*velocidad
	move_and_slide(movimiento,Vector2(0,0))

#Activar movimiento cuando es empujado
func _on_AreaDeteccionEmpuje_area_entered(area):
	if area.name == "AreaEmpujeAbajo":
		print("se detecto un empuje por arriba")
		direccion = Vector2(0,1)
		set_physics_process(true)
		$TiempoDesplazamiento.start()
		
	elif area.name == "AreaEmpujeArriba":
		print("se detecto un empuje por abajo")
		direccion = Vector2(0,-1)
		set_physics_process(true)
		$TiempoDesplazamiento.start()
		
	elif area.name == "AreaEmpujeIzquierda":
		print("se detecto un empuje por derecha")
		direccion = Vector2(-1,0)
		set_physics_process(true)
		$TiempoDesplazamiento.start()
		
	elif area.name == "AreaEmpujeDerecha":
		print("se detecto un empuje por izquierda")
		direccion = Vector2(1,0)
		set_physics_process(true)
		$TiempoDesplazamiento.start()
		
#Desactivar movimiento cuando termine el Timer
func _on_TiempoDesplazamiento_timeout():
	set_physics_process(false)
	movimiento = Vector2(0,0)
