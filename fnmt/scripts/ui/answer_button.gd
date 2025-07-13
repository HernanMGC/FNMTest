class_name AnswerButton
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
var answer_index : int = -1
#endregion PRIVATE VARIABLES

#region ONREADY PUBLIC VARIABLES
#endregion ONREADY PUBLIC VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
func set_button(in_text : String, index : int):
	text = in_text
	answer_index = index
#endregion PUBLIC METHODS

#region PRIVATE METHODS
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
