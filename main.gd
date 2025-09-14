extends Control

var fish_emotions = {
	"Happy": "Molamola:",
	"Sad": "Guppy:",
	"Lonely": "Dab:",
	"Neutral": "Koi:",
	"Confident": "Lionfish:",
	"Stressed": "Clownfish:",
	"Angry": "Triggerfish:",
	"Excited": "Goldfish:"
}


@onready var journal_box: Sprite2D = $JournalBox
@onready var fishing_button: TextureButton = $FishingButton
@onready var return_home: TextureButton = $ReturnHome

@onready var text_edit: TextEdit = $JournalBox/TextEdit

@onready var reel_in_button: TextureButton = $ReelInButton

@onready var animation_player: AnimationPlayer = $Fisher/AnimationPlayer

@onready var http_request: HTTPRequest = $HTTPRequest

@onready var length_error_warning: Label = $LengthErrorWarning




func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # RGBA, last value = alpha = 0 = transparent
	text_edit.add_theme_stylebox_override("normal", style)
	text_edit.add_theme_stylebox_override("focus", style)
	text_edit.add_theme_stylebox_override("read_only", style)
	animation_player.play("idle")


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
	animation_player.play("idle")
	length_error_warning.visible = false
	

func find_fish(word):
	var is_true = false
	for fish in fish_emotions.values():
		if word.contains(fish):
			is_true = true
	return is_true

func _on_reel_in_button_pressed() -> void:
	var words = text_edit.text.split(" ", true)  # true removes empty strings
	var word_count = words.size()
	
	if word_count < 6:
		length_error_warning.visible = true
	else:
		length_error_warning.visible = false
		text_edit.editable = false
		return_home.visible = false
		http_request.sentiment_analysis(text_edit.text)
		animation_player.play("fisher_reel_animation")
		animation_player.play("fisher_reel_animation_2")
	


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	var temp = json["answer"].replace("\n", " ").replace("\n\n", " ")
	var words_in_answer = temp.split(" ", true)
	
	var current_fish = ""
	var fish_explanation = ""
	var caught_fish = {}
	for word in words_in_answer:
		print(current_fish)
		if find_fish(word):
			print("FISH")
			if current_fish != "":
				caught_fish[current_fish] = fish_explanation
			current_fish = word
			fish_explanation = ""
		else:
			fish_explanation += word
			fish_explanation += " "
	print("====")
	print(caught_fish)
	animation_player.play("idle")
	
	
	
