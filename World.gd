extends Node2D

onready var Global = get_node("/root/Global")

func _ready():
	Global.level = 1
	Global.init()
	if Global.loaded:
		Global.load_coins()
		Global.load_enemies()
		for c in Global.coins:
			if Global.coins[c] == false:
				var temp = get_node("Coins/%s" % c)
				if temp:
					temp.queue_free()
		for e in Global.enemies:
			if Global.enemies[e] == false:
				var temp = get_node("Basic_Enemies/" + e)
				if temp:
					temp.queue_free()
	Global.loaded = false
