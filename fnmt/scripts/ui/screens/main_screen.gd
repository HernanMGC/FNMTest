class_name MainScreen
extends Control

## Class Description.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
@export var setting_screen : Screen
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
## Hide Main Menu and try starting the game
func _on_play_button_pressed() -> void:
	hide()
	game.try_start()
	pass # Replace with function body.

func _on_update_db_update_pressed() -> void:
	game.update_db()
	pass # Replace with function body.
	
func _on_settings_pressed() -> void:
	if (setting_screen && ui_manager):
		ui_manager.push_screen(setting_screen)
	pass # Replace with function body.

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
