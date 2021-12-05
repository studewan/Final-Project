extends KinematicBody2D

var VP = null
var velocity = Vector2.ZERO
var speed = 0.2
var rotation_speed = 1.2
var max_speed = 1.5

var Bullet = preload("res://Bullet/Bullet.tscn")
onready var Bullets = get_node("/root/Game/Bullets")


func _ready():
	VP = get_viewport().size

func _physics_process(_delta):
	velocity += get_input() * speed
	velocity = clamp(velocity.length(), 0, max_speed) * velocity.normalized()
	position += velocity 
	position.x = wrapf(position.x, 0, VP.x)
	position.y = wrapf(position.y, 0, VP.y)
	
	
	
func get_input():
	var toReturn = Vector2.ZERO
	if Input.is_action_pressed("up"):
		toReturn.y -= 1
	if Input.is_action_pressed("left"):
		rotation_degrees -= rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees += rotation_speed
	if Input.is_action_just_pressed("shoot"):
		var bullet = Bullet.instance()
		bullet.position = position + Vector2(0, -30).rotated(rotation)
		bullet.rotation = rotation
		Bullets.add_child(bullet)
	return toReturn.rotated(rotation)
	
func die():
	Global.change_lives(1)
	queue_free()
