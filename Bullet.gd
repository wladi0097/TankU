extends KinematicBody2D

var speed = 350
var velocity = Vector2()

func _ready():
	pass


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
	
		if "Bullet" in collision.collider.name:
#			collision.collider.get_node("explode").emitting = true
			collision.collider.queue_free()
			
#			self.get_node("explode").emitting = true
			self.queue_free()
	pass

func set_bullet_direction(direction: Vector2):
	velocity = direction * speed


func _on_Area2D_body_entered(body):
	print(body)
