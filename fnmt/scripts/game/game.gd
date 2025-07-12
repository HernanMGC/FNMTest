class_name Game
extends Node

## Class Description.

#region SIGNALS
## Signal for game is ready. Game is considered ready when HTTP request for
## retrieving questions is done and json is parsed for the game to prompt
## questions.
signal on_game_is_ready
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PRIVATE VARIABLES
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
## HTTP requester reference used to retrieve game questions.
@onready var http_requester : HTTPRequester = $HTTPRequester
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready registers itself to global variables and connects to HTTP requester
## on_questions_retrieve signal to set game as ready.
func _ready() -> void:
	Global.game = self
	
	if (!http_requester):
		return
	
	http_requester.on_questions_retrieved.connect(_on_questions_retrieved)
	
## Reacts to on_questions_retrieved and parse JSON to set game as ready.
func _on_questions_retrieved(json : Variant) -> void:
	http_requester.on_questions_retrieved.disconnect(_on_questions_retrieved)
	# TODO parse JSON
	print(json[1])
	on_game_is_ready.emit()
	pass
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
