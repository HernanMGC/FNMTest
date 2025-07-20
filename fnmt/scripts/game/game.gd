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

## SQL database
var database : SQLite

var questions_table : String = "questions"
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
	print("get_random_question(): " + current_question.question_id)
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
	
	open_database()
	try_create_table()
	try_populate_questions()

## Ope database for write.
func open_database():
	database = SQLite.new()
	database.path = 'user://data.db'
	database.open_db()
	
## Create questions table
func try_create_table() -> void:
	var table_definition = {
		"id" : {"data_type" : "text", "primary_key" : true, "not_null" : true},
		"exam_id" : {"data_type" : "text"},
		"q_number" : {"data_type" : "int"},
		"q_category" : {"data_type" : "text"},
		"position" : {"data_type" : "text"},
		"date" : {"data_type" : "date"},
		"level" : {"data_type" : "int"},
		"q_text" : {"data_type" : "text"},
		"q_option_a" : {"data_type" : "text"},
		"q_option_b" : {"data_type" : "text"},
		"q_option_c" : {"data_type" : "text"},
		"q_option_d" : {"data_type" : "text"},
		"q_option_e" : {"data_type" : "text"},
		"q_option_f" : {"data_type" : "text"},
		"q_answer" : {"data_type" : "text"}
	}
	database.create_table(questions_table, table_definition)

## Tries to retrieve all questions and caches on questions var, if database is empty
func try_populate_questions() -> void:
	var rows = database.select_rows(questions_table, "", ["*"])
	if rows.size() <= 0:
		http_requester.start_query()
		http_requester.questions_retrieved.connect(_on_request_finished)
	else:
		parse_db_rows_to_questions(rows)
		current_question = questions[0]
		current_question_changed.emit(current_question)
		print("try_populate_questions(): " + current_question.question_id)
		is_game_ready = true
		game_is_ready.emit()

## Creates questions resource from rows.
func parse_db_rows_to_questions(rows : Array[Dictionary]) -> void:
	for row : Dictionary in rows:
		var question : Question = Question.new()
		question.question_id = row["id"]
		question.opo_code = row["exam_id"]
		question.question_number = row["q_number"]
		question.question_category = Global.parse_question_category(row["q_category"])
		question.position = row["position"]
		question.published_date = row["date"]
		question.level = row["level"]
		question.question_body = row["q_text"]
		question.answers.append(str(row["q_option_a"]))
		question.answers.append(str(row["q_option_b"]))
		question.answers.append(str(row["q_option_c"]))
		question.answers.append(str(row["q_option_d"]))
		question.answers.append(str(row["q_option_e"]))
		question.answers.append(str(row["q_option_f"]))
		question.correct_answer = Global.parse_question_answer(row["q_answer"])
		questions.append(question)

## Insert quetion into table
func insert_question(json : Variant) -> void:
	var id : String = json["id"];
	
	var new_question_entry = {
		"exam_id" : json["exam_id"],
		"q_number" : int(json["q_number"]),
		"q_category" : json["q_category"],
		"position" : json["position"],
		"date" : json["date"],
		"level" : int(json["level"]),
		"q_text" : json["q_text"],
		"q_option_a" : json["q_option_a"],
		"q_option_b" : json["q_option_b"],
		"q_option_c" : json["q_option_c"],
		"q_option_d" : json["q_option_d"],
		"q_option_e" : json["q_option_e"],
		"q_option_f" : json["q_option_f"],
		"q_answer" : json["q_answer"]
	}

	database.select_rows(questions_table, "id = '" + id + "'", ["id"])
	var query_result : Array = database.query_result
	if !query_result.is_empty():
		database.update_rows(questions_table, "id = '"+ id +"'", new_question_entry)
	else:
		new_question_entry["id"] = id
		database.insert_row(questions_table, new_question_entry)
			
## Reacts to on_questions_retrieved and parse JSON to set game as ready.
func _on_request_finished(json : Variant) -> void:
	http_requester.questions_retrieved.disconnect(_on_request_finished)
	
	if json.size() <= 0:
		return
		
	# TODO parse JSON
	for json_line in json:
		insert_question(json_line)
	
	try_populate_questions()
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
