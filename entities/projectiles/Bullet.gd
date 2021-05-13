extends KinematicBody2D
class_name BaseBullet

var speed = 350
var velocity = Vector2()
var bouncesLeft = 1
onready var animationPlayer := $AnimationPlayer
onready var collisionShape := $CollisionShape2D
onready var sprite := $Sprite

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)	
	if collision:
		if "Tank" in collision.collider.name: # Tank destroys bullet
			return

		velocity = velocity.bounce(collision.normal)
	
		if "Bullet" in collision.collider.name:
			destroyOther(collision.collider)
			die()
		
		if bouncesLeft == 0:
			die()
		bouncesLeft -= 1

func set_bullet_direction(direction: Vector2):
	velocity = direction * speed
	
func die():
	destroyOther(self)
	
func destroyOther(bulletEntity):
	bulletEntity.collisionShape.disabled = true
	bulletEntity.sprite.visible = false
	bulletEntity.animationPlayer.play("die")
	yield(animationPlayer, "animation_finished")
	bulletEntity.queue_free()
