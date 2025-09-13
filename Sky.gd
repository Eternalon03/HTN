extends Node2D

@export var sky_height: float = 0.2

@onready var sky: Sprite2D = $Sky

var _position_nrm: Vector2

var area: Rect2:
	set(value):
		area = value
		_calc_sky_rect()
		

func _calc_sky_rect():
	sky.size.x = area.size.x
	sky.size.y = area.size.x * sky_height
	sky.position = -sky.size / 2
	
