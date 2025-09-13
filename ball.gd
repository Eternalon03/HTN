extends Node2D

@export var ball_size: float = 0.04

@onready var dot: ColorRect = $Dot

var _position_nrm: Vector2

func _ready():
	_init_position()
	
func _init_position():
	_position_nrm = Vector2(0.5, 0.5)

var area: Rect2:
	set(value):
		area = value
		_calc_ball_rect()

func _calc_ball_rect():
	dot.size.x = ball_size * area.size.x
	dot.size.y = dot.size.x
	dot.position = -dot.size / 2
	

