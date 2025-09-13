extends Control

@onready var journal_box: Sprite2D = $JournalBox
@onready var fishing_button: TextureButton = $FishingButton
@onready var return_home: TextureButton = $ReturnHome

@onready var text_edit: TextEdit = $JournalBox/TextEdit

@onready var reel_in_button: TextureButton = $ReelInButton



func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # RGBA, last value = alpha = 0 = transparent
	text_edit.add_theme_stylebox_override("normal", style)
	text_edit.add_theme_stylebox_override("focus", style)
	text_edit.add_theme_stylebox_override("read_only", style)
	pass


func _on_texture_button_pressed() -> void:
	text_edit.editable = true
	journal_box.visible = true
	fishing_button.visible = false
	return_home.visible = true
	reel_in_button.visible = true


func _on_return_home_pressed() -> void:
	return_home.visible = false
	journal_box.visible = false
	fishing_button.visible = true
	text_edit.text = ""
	text_edit.set_caret_line(0)
	text_edit.set_caret_column(0)
	reel_in_button.visible = false
	


func _on_reel_in_button_pressed() -> void:
	text_edit.editable = false
