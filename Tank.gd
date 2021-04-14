extends KinematicBody2D

onready var canon := $canon
onready var shootPoint := $canon/Shootpoint
onready var shootTimer := $ShootTimer
onready var bullet = preload("res://Bullet.tscn")

var moveSpeed = 300
var rotationSpeed = 2
var bulletSpeed = 350
var canShoot = true

func _ready():
	shootTimer.connect("timeout", self, "enableShoot")
	pass
	
func enableShoot():
	canShoot = true

func _input(event):
	if canShoot && event.is_action_pressed("leftClick"):
		canShoot = false

		var bullet_instance = bullet.instance()
		bullet_instance.position = shootPoint.global_position
		bullet_instance.look_at(get_global_mouse_position())
		bullet_instance.set_bullet_direction(Vector2(1, 0).rotated(canon.global_rotation))
#		bullet_instance.apply_impulse(Vector2(), Vector2(bulletSpeed, 0).rotated(canon.global_rotation))
		
		get_tree().get_root().call_deferred("add_child", bullet_instance)
		$canon/CPUParticles2D.emitting = true
		shootTimer.start()
		
func _physics_process(delta):
	
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed("down"):
		movement.x = -1;
	if Input.is_action_pressed("up"):
		movement.x = 1;
	if Input.is_action_pressed("left"):
		self.rotation_degrees -= rotationSpeed;
	if Input.is_action_pressed("right"):
		self.rotation_degrees += rotationSpeed;
		
	movement = movement.rotated(self.rotation)
	self.move_and_slide(movement * moveSpeed)
	
	canon.look_at(get_global_mouse_position())
	pass
