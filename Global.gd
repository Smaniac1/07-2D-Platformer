extends Node2D

var score = 0
var lives = 0
var level = 0

var save_path = "res://savegame.sav"
var config = ConfigFile.new()
var load_data = config.load(save_path)

func save_data():
	config.set_value("Save","score",score)
	config.set_value("Save","lives",lives)
	config.set_value("Save","level",level)
	config.save(save_path)

func load_data():
	score = config.get_value("Save","score")
	lives = config.get_value("Save","lives")
	level = config.get_value("Save","level")
	if level == 0:
		get_tree().change_scene("res://Start Menu.tscn")
	if level == 1:
		get_tree().change_scene("res://World.tscn")
	if level == 2:
		get_tree().change_scene("res://World2.tscn")



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
