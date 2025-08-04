class_name MainMenu
extends Control

## Class Description.

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
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Hide Main Menu and try starting the game
func _on_play_button_pressed() -> void:
	hide()
	game.try_start()
	pass # Replace with function body.

func _on_play_db_update_pressed() -> void:
	game.update_db()
	pass # Replace with function body.
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready connect to on_game_is_ready signal to stop loading spinner.
func _ready() -> void:
	game = Global.game
	if (!game):
		return
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
