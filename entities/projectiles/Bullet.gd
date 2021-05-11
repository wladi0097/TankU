extends KinematicBody2D

var speed = 350
var velocity = Vector2()
onready var animationPlayer := $AnimationPlayer
onready var sprite := $Sprite

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
	
		if "Bullet" in collision.collider.name:
			die(collision.collider)
			die(self)
			
	pass

func set_bullet_direction(direction: Vector2):
	velocity = direction * speed
	
func die(bulletEntity):
	bulletEntity.sprite.visible = false
	bulletEntity.animationPlayer.play("die")
	yield(animationPlayer, "animation_finished")
	bulletEntity.queue_free()
