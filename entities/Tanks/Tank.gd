extends KinematicBody2D

export var isPlayer : bool = false

onready var canon := $canon
onready var shootPoint := $canon/Shootpoint
onready var shootTimer := $ShootTimer
onready var collision := $MainCollision
onready var bulletDetectCollision := $BulletCollision/CollisionPolygon2D
onready var camera := $Camera2D
onready var sprite := $Sprite
onready var animationPLayer := $AnimationPlayer
onready var bullet = preload("res://entities/projectiles/Bullet.tscn")
onready var navigation: Navigation2D = get_parent()
onready var line: Line2D = get_parent().get_node("Line2D")

var moveSpeed = 300
var rotationSpeed = 2
var bulletSpeed = 350
var canShoot = true
var isDead = false
var rnd = RandomNumberGenerator.new()

func _ready():
	shootTimer.connect("timeout", self, "enableShoot")
	if isPlayer:
		Global.player = self
	else:
		self.moveSpeed = 150
		camera.current = false
	pass
	
func enableShoot():
	canShoot = true
	
func _on_BulletCollision_body_entered(enteredBullet):
	enteredBullet.destroySelf()
	die()

func _input(event):
	if !isPlayer:
		return
		
	if event.is_action_pressed("leftClick"):
		shoot()
		
func _physics_process(_delta):
	if isDead:
		return
	
	if isPlayer:
		playerControll()
	else:
		ai()
	
func playerControll():
	var movement = Vector2(0, 0)
	
	if Input.is_action_pressed("down"):
		movement.x = -1;
	if Input.is_action_pressed("up"):
		movement.x = 1;
	if Input.is_action_pressed("left"):
		self.rotation_degrees -= rotationSpeed;
	if Input.is_action_pressed("right"):
		self.rotation_degrees += rotationSpeed;
		
	self.move_and_slide(movement.rotated(self.rotation) * moveSpeed)
	canon.look_at(get_global_mouse_position())

func ai():
	if !Global.playerExists():
		return
	
	var path = navigation.get_simple_path(self.position, Global.getGlobalPlayerPosition())
	path.remove(0)
	var nextWantedPosition: Vector2 = path[0]
	
	var rayCast = get_world_2d().direct_space_state.intersect_ray(
		self.shootPoint.global_position,
		Global.getPLayerInstance().shootPoint.global_position,
		[self, Global.getPLayerInstance()]
	)
	
	canon.look_at(Global.getGlobalPlayerPosition())
	if rayCast.empty():
		shoot()
	
	self.rotation = lerp_angle(self.rotation, nextWantedPosition.angle_to_point(self.position), 0.02)
	self.move_and_slide(Vector2(1, 0).rotated(self.rotation) * moveSpeed)
		
		
func shoot():
	if !canShoot:
		return
		
	canShoot = false

	var bullet_instance = bullet.instance()
	bullet_instance.position = shootPoint.global_position
	bullet_instance.set_bullet_direction(Vector2(1, 0).rotated(canon.global_rotation))
	
	get_tree().get_root().call_deferred("add_child", bullet_instance)
	$canon/CPUParticles2D.emitting = true
	shootTimer.start()

func die():
	isDead = true
	animationPLayer.play("die" + String(rnd.randi_range(0, 2)))
	yield(animationPLayer, "animation_finished")
	queue_free()
