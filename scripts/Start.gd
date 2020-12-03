extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStart.play()
	pass # Replace with function body.

func _input(event):
	if event.is_action_released("ui_accept"):
		get_tree().change_scene("res://scenes/Main.tscn")
