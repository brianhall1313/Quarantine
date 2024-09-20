extends PanelContainer

signal back_to_game
signal quit_game



func _on_continue_button_up():
	back_to_game.emit()


func _on_quit_to_main_button_up():
	quit_game.emit()
