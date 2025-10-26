extends Control

@onready var displayText = $"MarginContainer/display text"
@onready var txtEdit = $TextEdit
@onready var timer = $Timer
@onready var status = $Label
@onready var errorLettersRichTxt = $MarginContainer/typedtxt

var fp = FakePayloads.new()
var active_p

func _ready() -> void:
	randomize()
	set_payload()
	timer.start()


func _on_text_edit_text_changed() -> void:
	var input_text = txtEdit.text
	var full_text = "\n".join(active_p["text_lines"]) # join lines for comparison
	
	# Too many characters
	if input_text.length() > full_text.length():
		status.text = "❌ Too many characters!"
		return

	var mistakes := []
	for i in range(input_text.length()):
		var typed_char = input_text[i]
		var correct_char = full_text[i]
		if typed_char != correct_char:
			mistakes.append("%s (expected '%s')" % [typed_char, correct_char])

	if mistakes.size() > 0:
		status.text = "Wrong letter(s): " + ", ".join(mistakes)
	else:
		status.text = "✅ So far, so good!"

	# Full text typed correctly
	if input_text == full_text:
		status.text = "🎉 Sentence completed!"
		print("✅ Sentence completed!")
		set_payload()
		displayText.text = "\n".join(active_p["text_lines"])
		timer.wait_time = active_p["timer"]
		timer.start()

func set_payload():
	active_p = fp.long_fake_payloads[randi() % fp.long_fake_payloads.size()]
	displayText.text = "\n".join(active_p["text_lines"])
	timer.wait_time = active_p["timer"]
	txtEdit.text = ''
	status.text = "Start typing..."



func _on_timer_timeout() -> void:
	set_payload()
	print("⏱ Timer tick — you can add timed logic here.")


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
