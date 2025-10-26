extends Control

@onready var displayText = $"MarginContainer/display text"
@onready var txtEdit: TextEdit = $MarginContainer/TextEdit
@onready var timer = $Timer
@onready var status = $Label
@onready var timer_label: Label = $"../../HUD/TextureRect/TimerLabel"

var fp = FakePayloads.new()
var active_p
var time_left: float = 0.0

# Track last checked index to avoid repeated wrong triggers for the same character
var last_checked_index := -1

func _ready() -> void:
	randomize()
	set_payload()
	timer.start()
	txtEdit.grab_focus()

func _on_text_edit_text_changed() -> void:
	var input_text = txtEdit.text
	var full_text = "\n".join(active_p["text_lines"]) # join lines for comparison
	
	# Too many characters
	if input_text.length() > full_text.length():
		status.text = "❌ Too many characters!"
		return

	# Only check new characters typed
	for i in range(last_checked_index + 1, input_text.length()):
		var typed_char = input_text[i]
		var correct_char = full_text[i].to_lower()

		if typed_char == correct_char:
			status.text = "✅ Correct letter: '%s'" % typed_char
			get_parent().get_parent().get_parent().handle_correct_arrow()
		else:
			status.text = "❌ Wrong letter: '%s' (expected '%s')" % [typed_char, correct_char]
			get_parent().get_parent().get_parent().handle_wrong_arrow()

	# Update last checked index
	last_checked_index = input_text.length() - 1

	# Full sentence typed completely
	if input_text == full_text:
		status.text = "🎉 Sentence completed!"
		print("✅ Sentence completed!")
		set_payload()
		displayText.text = "\n".join(active_p["text_lines"])
		timer.wait_time = active_p["timer"]
		timer.start()
		time_left = active_p["timer"]
		txtEdit.text = ""
		last_checked_index = -1  # Reset for next sentence

func set_payload():
	active_p = fp.long_fake_payloads[randi() % fp.long_fake_payloads.size()]
	displayText.text = "\n".join(active_p["text_lines"]).to_lower()
	timer.wait_time = active_p["timer"]
	txtEdit.text = ''
	status.text = "Start typing..."
	time_left = active_p["timer"]
	timer_label.text = str(int(time_left)) # initialize label
	last_checked_index = -1

func _on_timer_timeout() -> void:
	set_payload()
	get_parent().get_parent().get_parent().handle_wrong_arrow()
	print("⏱ Timer tick — you can add timed logic here.")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()

func _process(delta: float) -> void:
	if timer.is_stopped():
		return
	time_left -= delta
	if time_left < 0:
		time_left = 0
	timer_label.text = str(ceil(time_left))
