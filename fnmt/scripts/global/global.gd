extends Node

## Global enums and node for better accessibility.

## Enums for question categories.
enum QuestionCategory {
	None = 0,
	Specific,
	CollectiveAgreement,
	EqualityPlan,
	OSH
}

## Enums for question answers.
enum QuestionAnswer {
	Invalid = 0,
	A,
	B,
	C,
	D,
	E,
	F,
}

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
## Game node reference.
var game : Game = null

## Loading screen.
var game_screen : GameUi = null

## Loading screen.
var loading_screen : LoadingScreen = null
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
## Number of events that has made loading screen to appear on count reaching 0
## loading screen hides, over 0 loading screen shows.
var waiting_count : int = 0
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Parse json's question category and returns the proper enum for the game.
func parse_question_category(category_string : String) -> Global.QuestionCategory:
	match category_string:
		"Especifico": return Global.QuestionCategory.Specific
		"Convenio Colectivo": return Global.QuestionCategory.CollectiveAgreement
		"P. Igualdad": return Global.QuestionCategory.EqualityPlan
		"PRL": return Global.QuestionCategory.OSH
	
	return Global.QuestionCategory.None
	
## Parses json's question answer and retunrs the proper enum for the game. 
func parse_question_answer(answer : String) -> Global.QuestionAnswer:
	match answer:
		"A": return Global.QuestionAnswer.A
		"B": return Global.QuestionAnswer.B
		"C": return Global.QuestionAnswer.C
		"D": return Global.QuestionAnswer.D
		"E": return Global.QuestionAnswer.E
		"F": return Global.QuestionAnswer.F
	
	return Global.QuestionAnswer.Invalid

## Returns QuestionCategory nicename.
func get_category_nicename(category : Global.QuestionCategory) -> String :
	match category:
		Global.QuestionCategory.Specific: return "Especifico"
		Global.QuestionCategory.CollectiveAgreement: return "Convenio Colectivo"
		Global.QuestionCategory.EqualityPlan: return "Plan Igualdad"
		Global.QuestionCategory.OSH: return "PRL"
	
	return ""
	
## Show Game UI, it serves as game starter. It is assumed that questions are
## ready.
func show_game_ui() -> void:
	game_screen.show()
	pass
	
## Show UI
func show_loading_screen(wait_signal : Signal) -> void:
	if (waiting_count == 0):
		loading_screen.show()

	waiting_count += 1
	wait_signal.connect(on_wait_signal_received, CONNECT_ONE_SHOT)
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## Hide loading screen if waiting count reached 0.
func on_wait_signal_received() -> void:
	waiting_count = max(waiting_count - 1, 0)
	if (waiting_count == 0):
		loading_screen.hide()
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
