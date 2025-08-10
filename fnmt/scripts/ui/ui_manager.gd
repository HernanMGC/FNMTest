class_name UiManager
extends Node

## Class Description.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
var screen_container : Container = null
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Push new screen.
func push_screen(screen_resource : Screen) -> void:
	if (screen_container):
		screen_container.add_child(screen_resource.screen_scene.instantiate()) 
	return
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready register itself to global and connect to on_current_question_changed signal to stop loading spinner.
func _ready() -> void:
	Global.ui_manager = self
	return
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
