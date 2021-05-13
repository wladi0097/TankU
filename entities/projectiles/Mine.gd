extends RigidBody2D

var speed = 200
var velocity = Vector2()
var isActive = false

onready var ExplosionArea := $ExplosionArea
onready var animationPlayer := $AnimationPlayer
onready var collisionShape := $CollisionShape2D
onready var sprite := $Sprite

func set_direction(direction: Vector2):
	velocity = direction * speed

func get_velocity() -> Vector2:
	return velocity

func die():
	self.collisionShape.queue_free()
	self.sprite.visible = false
	self.animationPlayer.play("die")
	yield(animationPlayer, "animation_finished")
	queue_free()

func _on_HitArea_body_entered(body):
	if !isActive:
		return
		
	checkAndDestroy()

func checkAndDestroy():
	var bodies = ExplosionArea.get_overlapping_bodies()
	if !bodies.empty():
		for body in bodies:
			body.die()
		die()

func _on_ActivationTimer_timeout():
	isActive = true
	sprite.playing = true
	checkAndDestroy()
	set_mode(RigidBody2D.MODE_STATIC)
