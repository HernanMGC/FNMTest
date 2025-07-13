class_name Game
extends Node

## Class Description.

#region SIGNALS
## Signal for game is ready. Game is considered ready when HTTP request for
## retrieving questions is done and json is parsed for the game to prompt
## questions.
signal on_game_is_ready
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
var questions : Array[Question] = []
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
## HTTP requester reference used to retrieve game questions.
@onready var http_requester : HTTPRequester = $HTTPRequester
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready registers itself to global variables and connects to HTTP requester
## on_questions_retrieve signal to set game as ready.
func _ready() -> void:
	Global.game = self
	
	if (!http_requester):
		return
	
	http_requester.on_questions_retrieved.connect(_on_questions_retrieved)
	
## Reacts to on_questions_retrieved and parse JSON to set game as ready.
func _on_questions_retrieved(json : Variant) -> void:
	http_requester.on_questions_retrieved.disconnect(_on_questions_retrieved)
	
	# TODO parse JSON
	for json_line in json:
		var question : Question = Question.new()
		question.question_id = json_line["id"]
		question.opo_code = json_line["exam_id"]
		question.question_number = json_line["q_number"]
		question.question_category = parse_question_category(json_line["q_category"])
		question.position = json_line["position"]
		question.published_date = json_line["date"]
		question.level = json_line["level"]
		question.question_body = json_line["q_text"]
		question.answers.append(json_line["q_option_a"])
		question.answers.append(json_line["q_option_b"])
		question.answers.append(json_line["q_option_c"])
		question.answers.append(json_line["q_option_d"])
		question.answers.append(json_line["q_option_e"])
		question.answers.append(json_line["q_option_f"])
		question.correct_answer = parse_question_answer(json_line["q_answer"])
		questions.append(question)
		
	print(questions[0])
	
	on_game_is_ready.emit()
	pass
	
func parse_question_category(category_string : String) -> Global.QuestionCategory:
	match category_string:
		"Especifico": return Global.QuestionCategory.Specific
		"Convenio Colectivo": return Global.QuestionCategory.CollectiveAgreement
		"Plan Igualdad": return Global.QuestionCategory.EqualityPlan
		"PRL": return Global.QuestionCategory.OSH
	
	return Global.QuestionCategory.None
	
func parse_question_answer(answer : String) -> Global.QuestionAnswer:
	match answer:
		"A": return Global.QuestionAnswer.A
		"B": return Global.QuestionAnswer.B
		"C": return Global.QuestionAnswer.C
		"D": return Global.QuestionAnswer.D
		"E": return Global.QuestionAnswer.E
		"F": return Global.QuestionAnswer.F
	
	return Global.QuestionAnswer.Invalid
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
