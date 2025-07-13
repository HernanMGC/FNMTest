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
## used to connecto on_game_is_ready signal. 
var game : Game = null
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
@onready var opo_code_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/HSplitContainer/MarginContainer/OpoCode
@onready var question_number_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/HSplitContainer/MarginContainer/QuestionNumber
@onready var question_body_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/QuestionBody
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready connect to on_game_is_ready signal to stop loading spinner.
func _ready() -> void:
	game = Global.game
	if (!game):
		return
	
	game.on_game_is_ready.connect(_on_game_is_ready)
	
## Reacts to game's on_game_is_ready signal to stop loading spinner.
func _on_game_is_ready():
	var question : Question = game.get_random_question()
	opo_code_label.text = question.opo_code
	question_number_label.text = "#" + str(question.question_number)
	question_body_label.text = question.question_body
	pass
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
