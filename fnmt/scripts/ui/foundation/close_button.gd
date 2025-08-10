class_name CloseButton
extends Button

## Class Description.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
var ui_manager : UiManager = null
#endregion PRIVATE VARIABLES

#region ONREADY PUBLIC VARIABLES
#endregion ONREADY PUBLIC VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready connect to on_game_is_ready signal to stop loading spinner.
func _ready() -> void:
	ui_manager = Global.ui_manager
	if (!ui_manager):
		return

func _on_pressed() -> void:
	if (ui_manager):
		ui_manager.pop_screen()
	pass # Replace with function body.
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
