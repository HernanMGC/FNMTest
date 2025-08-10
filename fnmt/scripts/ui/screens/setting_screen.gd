class_name SettingScreen
extends Control

## Class Description.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PRIVATE VARIABLES
## Game node reference. It will be retrieved by calling for globals and will be
## used to connecto on_game_is_ready signal. 
var game : Game = null
var ui_manager : UiManager = null
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready connect to on_game_is_ready signal to stop loading spinner.
func _ready() -> void:
	game = Global.game
	ui_manager = Global.ui_manager
	if (!game || !ui_manager):
		return
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
