class_name QuestionUi
extends Control

## Class Description.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
@export var ButtonScene : PackedScene
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
var answer_buttons : Array[AnswerButton]
#endregion PRIVATE VARIABLES

#region ONREADY PUBLIC VARIABLES
#endregion ONREADY PUBLIC VARIABLES

#region ONREADY PRIVATE VARIABLES
## Cached UI nodes.
@onready var opo_code_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/NinePatchOpoId/MarginContainer/OpoCode
@onready var question_number_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/NinePatchOpoId/MarginContainer/QuestionNumber
@onready var question_body_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/QuestionBody
@onready var question_category_label : Label = $Container/NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/NinePatchQuestionCategory/MarginContainer/QuestionCategory
@onready var answer_list_vbox : VBoxContainer = $Container/NinePatchRect/MarginContainer/VBoxContainer/AnswerList
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
## Setups a question UI information and create buttons for every possible answer.
func set_question(question : Question) -> void:
	if (!ButtonScene):
		return
		
	opo_code_label.text = question.opo_code
	question_number_label.text = "#" + str(question.question_number)
	question_body_label.text = question.question_body
	question_category_label.text = Global.get_category_nicename(question.question_category) 
	var answer_list_vbox_children = answer_list_vbox.get_children()
	for answer_button in answer_list_vbox_children:
		answer_button.free()
	answer_buttons.clear()
	var i : int = Global.QuestionAnswer.Invalid as int
	for answer in question.answers:
		i += 1
		if answer == "":
			continue
		
		var answer_button : AnswerButton = ButtonScene.instantiate()
		answer_button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		answer_button.set_button(answer, i)
		answer_list_vbox.add_child(answer_button)
		answer_buttons.append(answer_button)

## Set question UI feedback according to answer.
func set_question_answered_feedback(answer_sent : Global.QuestionAnswer, correct_answer : Global.QuestionAnswer) -> void:
	answer_buttons[correct_answer - 1].set_theme_type_variation("button_correct")
	if (correct_answer != answer_sent):
		answer_buttons[answer_sent - 1].set_theme_type_variation("button_incorrect")
		
#endregion PUBLIC METHODS

#region PRIVATE METHODS
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
