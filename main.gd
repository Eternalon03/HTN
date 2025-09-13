extends Control

@export var max_aspect: float = 0.75

@onready var aspect_ratio_container: AspectRatioContainer = $AspectRatioContainer

@onready var game_area: ColorRect = $AspectRatioContainer/GameArea

@onready var bat: Node2D = $AspectRatioContainer/GameArea/Bat

@onready var ball: Node2D = $AspectRatioContainer/GameArea/Ball



func _ready():
	_set_aspect()
	
func _set_aspect():
	var vp_rect = get_viewport_rect()
	var aspect = vp_rect.size.x / vp_rect.size.y
	
	aspect = min(max_aspect, aspect) # don't let it get too wide
	
	aspect_ratio_container.ratio = aspect
	
	

## resized is sent before _ready
#func _on_aspect_ratio_container_resized() -> void:
	#if is_node_ready():
		#_set_aspect()



func _on_game_area_item_rect_changed() -> void:
	bat.area = game_area.get_rect()
	ball.area = game_area.get_rect()


func _on_resized() -> void:
	if is_node_ready():
		_set_aspect()
