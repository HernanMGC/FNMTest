class_name Question
extends Resource

## Question resource.

#region SIGNALS
#endregion SIGNALS

#region VARIABLES
#region EXPORT VARIABLES
## Question id. It is a combination of opo_code and question_number.
var question_id : String = ""

## The ID for the opo position.
var opo_code : String = ""

## Question number in an exam.
var question_number : int = 0

## Question category.
var question_category : Global.QuestionCategory = Global.QuestionCategory.None

## Job position.
var position : String = ""

## Published date as string. It will probably need some parsing in the future.
var published_date : String = ""

## Job position level. It determines rights and salary among other stuff.
var level : int = 0

## Question body. In the future it will probably need to have some kind of
## marking language to allow images and such. For now it is just text.
var question_body : String = ""

## A list of answers parsed by json parser. In the data source they are separated
## columns.
var answers : Array[String] = []

## Index for the correct answer.
var correct_answer : int = -1
#endregion EXPORT VARIABLES

#region PUBLIC VARIABLES
#endregion PUBLIC VARIABLES

#region PRIVATE VARIABLES
#endregion PRIVATE VARIABLES

#region ONREADY PRIVATE VARIABLES
#endregion ONREADY PRIVATE VARIABLES
#endregion VARIABLES

#region METHODS
#region PUBLIC METHODS
#endregion PUBLIC METHODS

#region PRIVATE METHODS
#endregion PRIVATE METHODS

#region STATIC METHODS
#endregion STATIC METHODS
#endregion METHODS
