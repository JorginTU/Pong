extends Node

signal start

func change_score(p1,p2):
	$Label_score.text = str(p1) + " x " + str(p2)

func _on_Button_play_pressed():
	emit_signal("start")
	$Button_play.hide()
