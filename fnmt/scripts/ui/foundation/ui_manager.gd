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
	if (!screen_container):
		return
	
	screen_container.add_child(screen_resource.screen_scene.instantiate()) 
	return
	
## Push new screen.
func set_screen(screen_resource : Screen) -> void:
	if (!screen_container):
		return
	
	var children = screen_container.get_children()
	for child in children:
		child.free()
		
	screen_container.add_child(screen_resource.screen_scene.instantiate()) 
	return
	
## Pop up most screen.
func pop_screen() -> void:
	if (!screen_container):
		return
	
	if (screen_container.get_child_count() < 1):
		return
	
	screen_container.get_child(screen_container.get_child_count()-1).queue_free()
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
