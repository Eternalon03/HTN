extends Control

@onready var fish: Label = $Fish

@onready var text_edit: TextEdit = $TextEdit

@onready var fish_sprite: Sprite2D = $FishSprite






# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # RGBA, last value = alpha = 0 = transparent
	text_edit.add_theme_stylebox_override("normal", style)
	text_edit.add_theme_stylebox_override("focus", style)
	text_edit.add_theme_stylebox_override("read_only", style)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_fish(fish_new, description_new):
	fish.text = fish_new
	text_edit.text = description_new
	if fish_new == "Clownfish:":
		fish_sprite.texture = load("res://fish/Clownfish.PNG")
	elif fish_new == "Dab:":
		fish_sprite.texture = load("res://fish/Dabs.PNG")
	elif fish_new == "Goldfish:":
		fish_sprite.texture = load("res://fish/Goldfish.PNG")
	elif fish_new == "Guppy:":
		fish_sprite.texture = load("res://fish/Guppy.PNG")
	elif fish_new == "Koi:":
		fish_sprite.texture = load("res://fish/Koi.PNG")
	elif fish_new == "Lionfish:":
		fish_sprite.texture = load("res://fish/Lionfish.PNG")
	elif fish_new == "Molamola:":
		fish_sprite.texture = load("res://fish/molamola.PNG")
	elif fish_new:
		fish_sprite.texture = load("res://fish/Triggerfish.PNG")
		
