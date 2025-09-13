extends Node2D

@export var bat_width: float = 0.2 # normalized: percentage of game area width
@export var move_speed: float = 0.5 # fraction of width covered / second

@onready var bar: ColorRect = $Bar

var _position_nrm: Vector2 = Vector2(0.5,0.75) # normalized pos, centre of bat 

var area: Rect2:
	set(value): # property setter
		area = value
		_calc_bat_rect()
		
func _calc_bat_rect():
	bar.size.x = bat_width * area.size.x
	bar.size.y = bar.size.x * 0.2
	bar.position = -bar.size / 2
	position = area.size * _position_nrm
	
func _process(delta:float) -> void:
	if Input.is_action_pressed("ui_left"):
		_position_nrm.x = max(bat_width / 2, _position_nrm.x - delta * move_speed)
		_calc_bat_rect()
	elif Input.is_action_pressed("ui_right"):
		_position_nrm.x = min(1 - bat_width / 2, _position_nrm.x + delta * move_speed)
		_calc_bat_rect()
