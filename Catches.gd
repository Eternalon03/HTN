extends Control

@onready var grid_container: GridContainer = $GridContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func set_library(dictionary):
	# Clear any old children first (optional)
	for child in grid_container.get_children():
		child.queue_free()

	# Iterate over dictionary
	for fish in dictionary.keys():
		# Create a TextureRect (better than Sprite2D for UI containers)

		var icon := TextureRect.new()
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT

		icon.texture = load("res://backfish.png")
		icon.custom_minimum_size = Vector2(100, 100)
		
		var fish_icon := TextureRect.new()
		# Make fish_icon fill the entire icon
		fish_icon.anchor_left = 1
		fish_icon.anchor_top = 1
		fish_icon.anchor_right = 0
		fish_icon.anchor_bottom = 0
		fish_icon.stretch_mode = TextureRect.STRETCH_SCALE
		fish_icon.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		fish_icon.size_flags_vertical = Control.SIZE_EXPAND_FILL
		fish_icon.position = Vector2.ZERO             # top-left corner relative to parent

		
		var path = "res://fish/" + fish.rstrip(":") + ".PNG"
		
		print(path)
		fish_icon.texture = load(path)
		

		
		icon.add_child(fish_icon)


		# Add to grid
		grid_container.add_child(icon)

	
	
