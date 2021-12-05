extends Node2D

var Enemy = preload("res://Enemy/Enemy.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var e = Enemy.instance()
		add_child(e)
