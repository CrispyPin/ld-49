extends RichTextLabel


func _ready():
    pass

func asd():
	pass

func _process(_delta):
	text = ""
	#if Global.scoreTimer>0:
	text += "FPS : %0.02f\n\n" % Performance.get_monitor(0)
	text += "Time: %0.02f\n\n" % Global.scoreTimer
	
	if Global.scores.size()>0:
		text+="Scores:\n"
		for score in Global.scores:
			text += "Time: %0.02f, Boxes: %d\n" % score
			pass


	bbcode_text = text

