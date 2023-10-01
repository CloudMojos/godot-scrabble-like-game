extends CanvasLayer

signal letter_selected(letter)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	## Check the TextEdit's Text
	if ($TextEdit.text.length() != 1): 
		return
	## Assign it to a variable and instantiate a tile that will be placed in select
	var letter = $TextEdit.text.to_upper()
	## Clear TextEdit's text
	clear_text_edit()
	## Emit signal of selected letter
	letter_selected.emit(letter)
	
func clear_text_edit():
	$TextEdit.text == 'adsf'
