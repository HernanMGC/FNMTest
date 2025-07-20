class_name GameUi
extends Control

## Controls Game UI. Such as question info update.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
## Game node reference. It will be retrieved by calling for globals and will be
## used to connecto on_current_question_changed signal. 
var game : Game = null
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
## Question UI cached node.
@onready var question_ui : QuestionUi = $QuestionUI
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready register itself to global and connect to on_current_question_changed signal to stop loading spinner.
func _ready() -> void:
	Global.game_screen = self
	game = Global.game
	if (!game):
		return
	
	## TODO maybe this is a big patch.
	
	game.current_question_changed.connect(_on_current_question_changed)
	game.question_answered.connect(_on_question_answered)
	
	if game.get_is_game_ready():
		question_ui.set_question(game.current_question)
	
## Reacts to game's current_question_changed signal to stop loading spinner.
func _on_current_question_changed(question : Question):
	question_ui.set_question(question)
	pass
	
## Reacts to game's question_answered signal to add feedback for question UI.
func _on_question_answered(answer_sent : Global.QuestionAnswer, correct_answer : Global.QuestionAnswer):
	question_ui.set_question_answered_feedback(answer_sent, correct_answer)
	pass
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
