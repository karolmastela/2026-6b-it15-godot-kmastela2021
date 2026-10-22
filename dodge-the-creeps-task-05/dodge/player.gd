extends Area2D

signal hit

@export var speed: int = 400
var screen_size: Vector2


func _ready() -> void:
    screen_size = get_viewport_rect().size
    hide()


func _process(delta: float) -> void:
    var velocity := Input.get_vector("move_left", "move_right", "move_up", "move_down")
    position += velocity * speed * delta
    position = position.clamp(Vector2.ZERO, screen_size)


func start(pos: Vector2) -> void:
    position = pos
    show()
    $CollisionShape2D.disabled = false


func _on_body_entered(_body: Node2D) -> void:
    hide()
    hit.emit()
    $CollisionShape2D.set_deferred("disabled", true)
