class_name AnswerButton
extends Button

## Answer button class. It will send answers to game for it to process it.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
## Button index, it will be then parsed to Global.QuestionAnswer enum
## TODO maybe change it for QuestionAnswer directly.
var answer_index : int = -1
#endregion PRIVATE VARIABLES

#region ONREADY PUBLIC VARIABLES
## On ready connects pressed signal to _on_pressed event.
func _ready() -> void:
	self.pressed.connect(_on_pressed)
#endregion ONREADY PUBLIC VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Setups button by setting label with answer text and links it to answer index.
func set_button(in_text : String, index : int):
	text = in_text
	answer_index = index

## On pressed sends question answer to game. Game will processed it and send a
## a signal for the GameUI to capture for feedback.
func _on_pressed() -> void:
	var game : Game = Global.game
	if (!game):
		return
	
	game.answer_question(answer_index as Global.QuestionAnswer)
	pass # Replace with function body.
#endregion PUBLIC METHODS

#region PRIVATE METHODS
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
