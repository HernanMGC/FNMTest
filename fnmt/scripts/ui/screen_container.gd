class_name ScreenContainer
extends Container

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
func _ready() -> void:
	ui_manager = Global.ui_manager
	if (!ui_manager):
		return
	
	ui_manager.screen_container = self
	pass
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
