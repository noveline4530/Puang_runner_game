extends RigidBody2D

const UP_IMPULSE: float = -75.0
const DOWN_IMPULSE: float = 55.0
var beforePorint: int = 0
var point: int = 0

var torque = 1000

func _ready() -> void:
	collision_layer = 0
	set_collision_layer_bit(CollisionLayers.Layers.PUANG, true)
	collision_mask = 0
	set_collision_mask_bit(CollisionLayers.Layers.WALL, true)
	contacts_reported = 10
	contact_monitor = true

func _process(delta):
	if contact_monitor:
		var collide_body = get_colliding_bodies()
		for body in collide_body:
			if body.name != '@@5' and body.name != '@@3':
				body.set_position(body.get_position() + Vector2(-100000, 0))
				set_linear_velocity(Vector2(25, 0))
				if "coronavirus" in body.name:
					$AudioVirus.play()
					point -= 5
					if point < 0 :
						point = 0
						get_tree().change_scene("res://scenes/Gameover.tscn")
				if "mask" in body.name:
					$AudioMask.play()
					point += 1
				if "medicine" in body.name:
					$AudioMedicine.play()
					point += 2
				get_parent().get_node("Label").text = 'Score: ' + str(point)
				if point > 19 :						
						get_tree().change_scene("res://scenes/End.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("ui_up"):
			$AudioJump.play()
			_puang_up()			
		elif event.is_action_pressed("ui_down"):
			_puang_down()
		elif event.is_action_pressed("ui_left"):
			_puang_left()
		elif event.is_action_pressed("ui_right"):
			_puang_right()

func _puang_up() -> void:
	set_linear_velocity(Vector2(0, 0))
	apply_central_impulse(Vector2(0, UP_IMPULSE))
	$FlapAnimationPlayer.stop()
	$FlapAnimationPlayer.play("Flap")

func _puang_down() -> void:
	applied_force = Vector2()
	set_linear_velocity(Vector2(0, 0))
	apply_central_impulse(Vector2(0, DOWN_IMPULSE))
	$FlapAnimationPlayer.stop()
	$FlapAnimationPlayer.play("Flap")
#
func _puang_left() -> void:
	set_linear_velocity(Vector2(0, 0))
	apply_torque_impulse(-300)
	
func _puang_right() -> void:
	set_linear_velocity(Vector2(0, 0))
	apply_torque_impulse(300)
