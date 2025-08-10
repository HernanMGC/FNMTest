class_name LoadingSpinner
extends TextureProgressBar

## Class Description.

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
## Loading animation tween reference for stoping on loading complete.
var tween : Tween = null
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Stops and hides loading spinner.
func stop_spinner() -> void:
	tween.stop()
	hide()
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## Starts animation on ready until stop_spinner is called.
func _ready() -> void:
	tween = get_tree().create_tween().set_loops()
	tween.tween_property(self, "radial_initial_angle", 360.0, 1.5).as_relative()
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
