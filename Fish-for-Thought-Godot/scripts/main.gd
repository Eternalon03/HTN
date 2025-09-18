extends Control

var all_fish  = {}

var return_button_pos_x = 0
var return_button_pos_y = 0

const MIN_WORDS := 6
const LIBRARY_OFFSET_X := -190
const LIBRARY_OFFSET_Y := -230

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

@onready var network_error_warning: Label = $NetworkErrorWarning

@onready var journalling_animation_1_1_: Sprite2D = $"Fisher/JournallingAnimation1(1)"

func _ready():
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0, 0, 0, 0)  # RGBA, last value = alpha = 0 = transparent
	text_edit.add_theme_stylebox_override("normal", style)
	text_edit.add_theme_stylebox_override("focus", style)
	text_edit.add_theme_stylebox_override("read_only", style)
	animation_player.play("idle")
	network_error_warning.visible = true
	
	return_button_pos_x = return_home.position.x
	return_button_pos_y = return_home.position.y


# Helper methods to keep UI/state changes clean and consistent
func _play_idle() -> void:
	animation_player.play("idle")

func _restore_return_button_position() -> void:
	return_home.position.x = return_button_pos_x
	return_home.position.y = return_button_pos_y

func _clear_text_edit() -> void:
	text_edit.text = ""
	text_edit.set_caret_line(0)
	text_edit.set_caret_column(0)

func _show_home() -> void:
	catches_screen.visible = false
	library_button.visible = true
	return_home.visible = false
	journal_box.visible = false
	fishing_button.visible = true
	reel_in_button.visible = false
	length_error_warning.visible = false
	_play_idle()
	_restore_return_button_position()
	_clear_text_edit()

func _show_journaling() -> void:
	library_button.visible = false
	text_edit.editable = true
	journal_box.visible = true
	fishing_button.visible = false
	return_home.visible = true
	reel_in_button.visible = true

func _show_caught_screen() -> void:
	caught_screen.visible = true
	caught_reel_button.visible = true

func _show_library_view() -> void:
	catches_screen.visible = true
	return_home.visible = true
	return_home.position.x = return_button_pos_x + LIBRARY_OFFSET_X
	return_home.position.y = return_button_pos_y + LIBRARY_OFFSET_Y


func _on_texture_button_pressed() -> void:
	_show_journaling()


func _on_return_home_pressed() -> void:
	_show_home()
	

func find_fish(word: String) -> bool:
	var is_true := false
	for fish in fish_emotions.values():
		if word.contains(fish):
			is_true = true
	return is_true

func _on_reel_in_button_pressed() -> void:
	var words = text_edit.text.split(" ", true)  # true removes empty strings
	var word_count = words.size()
	
	if word_count < MIN_WORDS:
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
	var json_text: String = body.get_string_from_utf8()
	var parsed: Variant = JSON.parse_string(json_text)
	var ok_response: bool = response_code >= 200 and response_code < 300
	var has_answer: bool = parsed is Dictionary and (parsed as Dictionary).has("answer")

	if not ok_response or not has_answer:
		network_error_warning.text = "Network error. Please try again."
		network_error_warning.visible = true
		_show_home()
		animation_player.play("fade out")
		journalling_animation_1_1_.texture = load("res://images/Journalling_Animation1.png")
		return

	# Success path
	network_error_warning.visible = false
	var parsed_dict: Dictionary = parsed as Dictionary
	var temp: String = parsed_dict["answer"].replace("\n", " ").replace("\n\n", " ")
	var words_in_answer: PackedStringArray = temp.split(" ", true)

	var current_fish: String = ""
	var fish_explanation: String = ""
	for word in words_in_answer:
		if find_fish(word):
			if current_fish != "":
				caught_fish[current_fish] = fish_explanation
			current_fish = word
			fish_explanation = ""
		else:
			fish_explanation += word + " "
	if current_fish != "":
		caught_fish[current_fish] = fish_explanation
	_play_idle()
	journal_box.visible = false
	fishing_button.visible = true
	_clear_text_edit()
	reel_in_button.visible = false
	length_error_warning.visible = false
	_show_caught_screen()
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
	_show_library_view()
	
	catches_screen.set_library(all_fish)
	
	pass # Replace with function body.
