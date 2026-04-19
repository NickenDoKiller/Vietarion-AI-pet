extends Node2D

var speed = 50
var direction = 1

func _ready():
	# Bật xuyên thấu toàn bộ bằng cách truyền mảng trống
	DisplayServer.window_set_mouse_passthrough(PackedVector2Array())

func _process(delta):
	move_pet(delta)
	handle_mouse()

func move_pet(delta):
	var pet = $Pet
	pet.position.x += speed * direction * delta
	
	if pet.position.x > 700:
		direction = -1
	elif pet.position.x < 100:
		direction = 1

func handle_mouse():
	if is_mouse_over_pet():
		# Khi hover: Tạo một vùng bao quanh pet để bắt click
		# Ở đây ta lấy 4 góc của Texture để tạo thành vùng nhận click
		var pet = $Pet
		var size = pet.texture.get_size()
		var pos = pet.global_position - size / 2
		var region = PackedVector2Array([
			pos, 
			pos + Vector2(size.x, 0), 
			pos + size, 
			pos + Vector2(0, size.y)
		])
		DisplayServer.window_set_mouse_passthrough(region)
	else:
		# Không hover: Truyền mảng trống để click xuyên qua màn hình
		DisplayServer.window_set_mouse_passthrough(PackedVector2Array())

func is_mouse_over_pet():
	var pet = $Pet
	var mouse_pos = get_global_mouse_position()
	# Giả sử pet dùng Sprite2D và tâm (offset) ở giữa
	var rect = Rect2(pet.global_position - pet.texture.get_size()/2, pet.texture.get_size())
	return rect.has_point(mouse_pos)
