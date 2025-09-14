extends Control

var all_fish  = {"Clownfish": 1, "Koi": 2}

var return_button_pos_x = 0
var return_button_pos_y = 0

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

var on_key = 0
var caught_fish = {}


@onready var journal_box: Sprite2D = $JournalBox
@onready var fishing_button: TextureButton = $FishingButton
@onready var return_home: TextureButton = $ReturnHome

@onready var text_edit: TextEdit = $JournalBox/TextEdit

@onready var reel_in_button: TextureButton = $ReelInButton

@onready var animation_player: AnimationPlayer = $Fisher/AnimationPlayer

@onready var http_request: HTTPRequest = $HTTPRequest

@onready var length_error_warning: Label = $LengthErrorWarning

@onready var caught_screen: Control = $CaughtScreen
@onready var caught_reel_button: TextureButton = $CaughtScreen/CaughtReelButton

@onready var library_button: TextureButton = $LibraryButton

@onready var catches_screen: Control = $CatchesScreen








func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # RGBA, last value = alpha = 0 = transparent
	text_edit.add_theme_stylebox_override("normal", style)
	text_edit.add_theme_stylebox_override("focus", style)
	text_edit.add_theme_stylebox_override("read_only", style)
	animation_player.play("idle")
	
	return_button_pos_x = return_home.position.x
	return_button_pos_y = return_home.position.y


func _on_texture_button_pressed() -> void:
	library_button.visible = false
	text_edit.editable = true
	journal_box.visible = true
	fishing_button.visible = false
	return_home.visible = true
	reel_in_button.visible = true


func _on_return_home_pressed() -> void:
	catches_screen.visible = false
	library_button.visible = true
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
		library_button.visible = true
		http_request.sentiment_analysis(text_edit.text)
		animation_player.play("fisher_reel_animation")
		animation_player.play("fisher_reel_animation_2")
	


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.parse_string(body.get_string_from_utf8())
	var temp = json["answer"].replace("\n", " ").replace("\n\n", " ")
	var words_in_answer = temp.split(" ", true)
	
	var current_fish = ""
	var fish_explanation = ""
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
	if current_fish != "":
				caught_fish[current_fish] = fish_explanation
	print("====")
	print(caught_fish)
	animation_player.play("idle")
	return_home.visible = false
	journal_box.visible = false
	fishing_button.visible = true
	text_edit.text = ""
	text_edit.set_caret_line(0)
	text_edit.set_caret_column(0)
	reel_in_button.visible = false
	animation_player.play("idle")
	length_error_warning.visible = false
	caught_screen.visible = true
	caught_reel_button.visible = true
	var key1 = caught_fish.keys()[on_key]
	on_key += 1
	caught_screen.set_fish(key1, caught_fish[key1])
	
	
	


func _on_caught_reel_button_pressed() -> void:
	if on_key > caught_fish.keys().size() - 1:
		caught_reel_button.visible = false
		caught_screen.visible = false
		on_key = 0
		all_fish.merge(caught_fish)  
		caught_fish = {}
	else:
		var key1 = caught_fish.keys()[on_key]
		on_key += 1
		caught_screen.set_fish(key1, caught_fish[key1])


func _on_library_button_pressed() -> void:
	catches_screen.visible = true
	return_home.visible = true
	return_home.position.x = return_button_pos_x - 190
	return_home.position.y = return_button_pos_y - 230
	
	catches_screen.set_library(all_fish)
	
	pass # Replace with function body.
