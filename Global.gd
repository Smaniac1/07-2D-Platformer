extends Node2D

var score = 0
var level = 0
var current_coin_data_location = ""
var current_enemy_data_location = ""
var ci = 1
var ei = 1
var coin = ""
var enemy = ""

var save_path = "res://savegame.sav"
var config = ConfigFile.new()
var load_data = config.load(save_path)

func save_data():
	config.set_value("Save","score",score)
	config.set_value("Save","level",level)
	if level == 1:
		current_coin_data_location = get_tree().get_nodes_in_group("/root/World/Coins")
		current_enemy_data_location = get_tree().get_nodes_in_group("/root/World/Basic_Enemies")
	if level == 2:
		current_coin_data_location = get_tree().get_nodes_in_group("/root/World2/Coins")
		current_enemy_data_location = get_tree().get_nodes_in_group("/root/World2/Basic_Enemies")
	for body in current_coin_data_location:
		if ci == 1:
			config.set_value("Save_Coin", "coin", body)
		else:
			config.set_value("Save_Coin", "coin" + str(ci), body)
		ci += 1
	for body in current_enemy_data_location:
		if ei == 1:
			config.set_value("Save_Enemy", "enemy", body)
		else:
			config.set_value("Save_Enemy", "enemy" + str(ei), body)
		ei += 1
	config.set_value("Save", "coin_count", ci)
	config.set_value("Save", "enemy_count", ei)
	config.set_value("Save", "coin_data_location", current_coin_data_location)
	config.set_value("Save", "enemy_data_location", current_enemy_data_location)
	config.save(save_path)

func load_data():
	score = config.get_value("Save","score")
	level = config.get_value("Save","level")
	ci = config.get_value("Save", "coin_count")
	ei = config.get_value("Save", "enemy_count")
	current_coin_data_location = config.get_value("Save", "coin_data_location")
	current_enemy_data_location = config.get_value("Save", "enemy_data_location")
	load_coins()
	load_enemies()
	if level == 0:
		get_tree().change_scene("res://Start Menu.tscn")
	if level == 1:
		get_tree().change_scene("res://World.tscn")
	if level == 2:
		get_tree().change_scene("res://World2.tscn")

func load_coins():
	while ci > 0:
		if ci == 1:
			coin = config.get_value("Save_Coin", "coin")
		else:
			coin = config.get_value("Save_Coin", "coin" + str(ci))
		if coin.queue_free() == true:
			if level == 1:
				if ci == 1:
					get_node("/root/World/Coins/Coin").queue_free()
				else:
					get_node("/root/World/Coins/Coin" + str(ci)).queue_free()
			if level == 2:
				if ci == 1:
					get_node("/root/World/Coins/Coin").queue_free()
				else:
					get_node("/root/World/Coins/Coin" + str(ci)).queue_free()
		ci -= 1

func load_enemies():
	while ei > 0:
		if ei == 1:
			enemy = config.get_value("Save_Enemy", "enemy")
		else:
			coin = config.get_value("Save_Enemy", "enemy" + str(ci))
		if coin.queue_free() == true:
			if level == 1:
				if ei == 1:
					get_node("/root/World/Enemies/Enemy").queue_free()
				else:
					get_node("/root/World/Enemies/Enemy" + str(ci)).queue_free()
			if level == 2:
				if ei == 1:
					get_node("/root/World/Enemies/Enemy").queue_free()
				else:
					get_node("/root/World/Enemies/Enemy" + str(ci)).queue_free()
		ei -= 1


"""
func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		var new_object = load(current_line["filename"]).instance()
		get_node(current_line["parent"]).add_child(new_object)
		new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
		for i in current_line.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, current_line[i])
	save_game.close()
"""
