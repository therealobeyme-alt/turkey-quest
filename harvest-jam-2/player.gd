extends CharacterBody2D

const SPEED = 200.0
var facing = Vector2.DOWN
const DIRS = ["e", "se", "s", "sw", "w", "nw", "n", "ne"]

@onready var hitbox = $Hitbox
@onready var sword = get_node_or_null("Hitbox/SwordSprite")
@onready var body = $AnimatedSprite2D

func _ready():
	add_to_group("player")
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	hitbox.monitoring = false
	if sword:
		sword.visible = false

func _physics_process(_delta):
	var direction = Vector2.ZERO

	if Input.is_physical_key_pressed(KEY_W) or Input.is_physical_key_pressed(KEY_UP):
		direction.y -= 1
	if Input.is_physical_key_pressed(KEY_S) or Input.is_physical_key_pressed(KEY_DOWN):
		direction.y += 1
	if Input.is_physical_key_pressed(KEY_A) or Input.is_physical_key_pressed(KEY_LEFT):
		direction.x -= 1
	if Input.is_physical_key_pressed(KEY_D) or Input.is_physical_key_pressed(KEY_RIGHT):
		direction.x += 1

	if direction != Vector2.ZERO:
		facing = direction.normalized()

	velocity = direction.normalized() * SPEED
	move_and_slide()

	var step = posmod(int(round(facing.angle()
