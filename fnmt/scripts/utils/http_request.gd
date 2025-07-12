class_name HTTPRequester
extends Node

## Class that handle HTTP request to retrieve opos question from the google
## spreadsheet.

#region SIGNALS
signal on_questions_retrieved(questions : Variant)
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
## HTTP Request URL
@export var http_request_url : String = "https://script.googleusercontent.com/macros/echo?user_content_key=AehSKLgJQ_0jFZ1efVX7iE6Ck-v3w5daWYyhqv7uwsHvRxGRlS7T9jcvHTSNNf-qzI3eIZOQCIL9t-3yejDgSgEEpm0guY_7wN4c2tfTJkBTCtOw-kHl5CkEJYzqbfrJl3X9uBStNtp3d9e5GHLvPMnaBJrhMep48hGcUvsmMvt5t9xfYiFJf7lSFnIB49BtIF4Ws0qRKhwdg0K1_RRbnR8NOgj6bofQ6DZE7190k0nwyO9yPZpaGOEUDbHA_Ocx8Z3BwndaDkV_bpWPne6b4EUhuCuDAy9lLk0cHR4XJU1V&lib=MxzE7o1ml-SDzSVXK26NzmGGQ3iUwsvgU"
#endregion EXPORT VARIABLES

#region PRIVATE VARIABLES
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
## HTTP Request node reference.
@onready var http_request : Node = $HTTPRequest
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready prepares and execute request for opos questions.
func _ready():
	if !http_request:
		return
	http_request.request_completed.connect(_on_request_completed)
	http_request.request(http_request_url)

## On request completed print json headers.
func _on_request_completed(result, response_code, headers, body):
	http_request.request_completed.disconnect(_on_request_completed)
	var json : Variant = JSON.parse_string(body.get_string_from_utf8())
	on_questions_retrieved.emit(json);
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
