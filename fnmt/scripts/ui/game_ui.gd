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
## Question UI cached node.
@onready var question_ui : QuestionUi = $QuestionUI
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
	question_ui.set_question(question)
	pass
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
