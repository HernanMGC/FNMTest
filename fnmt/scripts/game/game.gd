class_name Game
extends Node

## Game manager class it will parse JSON to create questions and react to
## answers. Ultimately will send signals for the UIs to catch it to give the 
## user feedback.

#region SIGNALS
## Signal for game is ready. Game is considered ready when HTTP request for
## retrieving questions is done and json is parsed for the game to prompt
## questions.
signal game_is_ready

## Signal sent for question answered for UI to update its feedback, answerd_sent
## is the answer selected by the user in the answer_question call, and 
## correct_answer is the proper answer for the current question.
signal question_answered(answer_sent : Global.QuestionAnswer, correct_answer : Global.QuestionAnswer)

## Signarl sent when current question has changed.
signal current_question_changed(current_question : Question)
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
## Time to wait after answering a question for next question to appear.
@export var wait_for_next_question_time : float = 2.0
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
## Is game ready.
var is_game_ready : bool = false 

## Questions parsed.
var questions : Array[Question] = []

## Current question
var current_question : Question = null
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
## HTTP requester reference used to retrieve game questions.
@onready var http_requester : HTTPRequester = $HTTPRequester
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Returns game is ready
func get_is_game_ready() -> bool:
	return is_game_ready
 
## If questions are ready show Game UI, if not show Loading Screen. 
func try_start() -> void:
	if (get_is_game_ready()):
		Global.show_game_ui()
	else:
		Global.show_loading_screen(game_is_ready)
		game_is_ready.connect(Global.show_game_ui, CONNECT_ONE_SHOT)

## Gets random question and sets as current question. 
func get_random_question() -> Question:
	var rng = RandomNumberGenerator.new()
	var my_random_number = rng.randi_range(0, questions.size() - 1)
	
	current_question = questions[my_random_number]
	print(current_question.original_json)
	current_question_changed.emit(current_question)
	return current_question

## Answers question and launches feedback events.
func answer_question(answer_index : Global.QuestionAnswer):
	print(
		"Answered: " + str(answer_index) + " Correct Answer " + str(current_question.correct_answer) +
		" then " + ("Correct" if current_question.correct_answer == answer_index else "Incorrect")
	)
		
	## Signal sent for question answered for UI to update its feedback, answerd_sent
	## is the answer selected by the user in the )
	question_answered.emit(answer_index, current_question.correct_answer)
	await get_tree().create_timer(wait_for_next_question_time).timeout
	get_random_question()
	pass
#endregion PUBLIC METHODS

#region PRIVATE METHODS
## On ready registers itself to global variables and connects to HTTP requester
## on_questions_retrieve signal to set game as ready.
func _ready() -> void:
	Global.game = self
	
	if (!http_requester):
		return
	
	http_requester.questions_retrieved.connect(_on_questions_retrieved)
	
## Reacts to on_questions_retrieved and parse JSON to set game as ready.
func _on_questions_retrieved(json : Variant) -> void:
	http_requester.questions_retrieved.disconnect(_on_questions_retrieved)
	
	# TODO parse JSON
	for json_line in json:
		var question : Question = Question.new()
		question.original_json = json_line
		question.question_id = json_line["id"]
		question.opo_code = json_line["exam_id"]
		question.question_number = json_line["q_number"]
		question.question_category = Global.parse_question_category(json_line["q_category"])
		question.position = json_line["position"]
		question.published_date = json_line["date"]
		question.level = json_line["level"]
		question.question_body = json_line["q_text"]
		question.answers.append(str(json_line["q_option_a"]))
		question.answers.append(str(json_line["q_option_b"]))
		question.answers.append(str(json_line["q_option_c"]))
		question.answers.append(str(json_line["q_option_d"]))
		question.answers.append(str(json_line["q_option_e"]))
		question.answers.append(str(json_line["q_option_f"]))
		question.correct_answer = Global.parse_question_answer(json_line["q_answer"])
		questions.append(question)
		
	current_question = questions[0]
	current_question_changed.emit(current_question)
	print(current_question.original_json)
	is_game_ready = true
	game_is_ready.emit()
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
