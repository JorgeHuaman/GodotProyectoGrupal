extends KinematicBody2D

var direccion = "Zero"

func _ready():
	#Animación Inicial
	$AnimatedSprite.animation = "Start"
	
func _physics_process(delta):
	
	#Para el movimiento
	if Input.is_action_pressed("ui_down") and (direccion == "Down" or direccion == "Zero"):
		position.y += 2
		direccion = "Down"
	elif Input.is_action_pressed("ui_up") and (direccion == "Up" or direccion == "Zero"):
		position.y -= 2
		direccion = "Up"
	elif Input.is_action_pressed("ui_left") and (direccion == "Left" or direccion == "Zero"):
		position.x -= 2
		direccion = "Left"
	elif Input.is_action_pressed("ui_right") and (direccion == "Right" or direccion == "Zero"):
		position.x += 2
		direccion = "Right"
		
	#Para asegurarse que está mirando a la dirección correcta puedes usar este print
	#print(direccion)
		
	#Para seleccionar la animación correcta
	if Input.is_action_just_pressed("ui_down") and direccion == "Down":
		$AnimatedSprite.animation = "WalkDown"
		$AnimatedSprite.play()
	elif Input.is_action_just_pressed("ui_up") and direccion == "Up":
		$AnimatedSprite.animation = "WalkUp"
		$AnimatedSprite.play()
	elif Input.is_action_just_pressed("ui_left") and direccion == "Left":
		$AnimatedSprite.animation = "WalkLeft"
		$AnimatedSprite.play()
	elif Input.is_action_just_pressed("ui_right") and direccion == "Right":
		$AnimatedSprite.animation = "WalkRight"
		$AnimatedSprite.play()
		
	if Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down") or Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		direccion = "Zero"
		$AnimatedSprite.animation = "Start"
		
