extends CharacterBody3D

@export var speed: float = 14.0
@export var fall_acceleration: float = 75.0
@export var jump_impulse: float = 20.0

var target_velocity: Vector3 = Vector3.ZERO


func _physics_process(delta: float) -> void:
    var direction: Vector3 = Vector3.ZERO

    if Input.is_action_pressed("move_right"):
        direction.x += 1.0
    if Input.is_action_pressed("move_left"):
        direction.x -= 1.0
    if Input.is_action_pressed("move_down"):
        direction.z += 1.0
    if Input.is_action_pressed("move_up"):
        direction.z -= 1.0

    if direction != Vector3.ZERO:
        direction = direction.normalized()
        # Figur in Bewegungsrichtung drehen
        $Pivot.basis = Basis.looking_at(direction)

    # Boden-Geschwindigkeit setzen
    target_velocity.x = direction.x * speed
    target_velocity.z = direction.z * speed

    # Schwerkraft anwenden
    if not is_on_floor():
        target_velocity.y -= fall_acceleration * delta

    # Sprung ausführen
    if is_on_floor() and Input.is_action_just_pressed("jump"):
        target_velocity.y = jump_impulse

    velocity = target_velocity
    move_and_slide()
