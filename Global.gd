extends Node2D

var score = 0
var level = 0
var ci = 1
var ei = 1
var coins = {}
var enemies = {}
var loaded = false

onready var level1 = load("res://World.tscn")
onready var level2 = load("res://World2.tscn")
onready var start = load("res://Start Menu.tscn")

var save_path = "res://savegame.sav"
var config = ConfigFile.new()
var load_data = config.load(save_path)

func init():
	var current_coins = get_tree().get_nodes_in_group("Coins")
	for c in current_coins:
		coins[c.name] = true
	var current_enemies = get_tree().get_nodes_in_group("BasicEnemies")
	for e in current_enemies:
		enemies[e.name] = true
	


func save_data():
	config.set_value("Save","score",score)
	config.set_value("Save","level",level)
	var current_coins = get_tree().get_nodes_in_group("Coins")
	ci = 0
	for c in coins:
		coins[c] = false
	for c in current_coins:
		coins[c.name] = true
		ci += 1
	for c in coins:
		config.set_value("Save_Coin", c, coins[c])
	var current_enemies = get_tree().get_nodes_in_group("BasicEnemies")
	ei = 0
	for e in enemies:
		enemies[e] = false
	for e in current_enemies:
		enemies[e.name] = true
		ei += 1
	for e in enemies:
		config.set_value("Save_Enemy", e, enemies[e])
	config.set_value("Save", "coin_count", ci)
	config.set_value("Save", "enemy_count", ei)
	config.save(save_path)

func load_data():
	score = config.get_value("Save","score")
	level = config.get_value("Save","level")
	ci = config.get_value("Save", "coin_count")
	ei = config.get_value("Save", "enemy_count")
	loaded = true
	if level == 0:
		get_tree().change_scene_to(start)
	if level == 1:
		get_tree().change_scene_to(level1)
	if level == 2:
		get_tree().change_scene_to(level2)

func load_coins():
	for c in coins:
		if config.get_value("Save_Coin", c) == false:
			coins[c] = false

func load_enemies():
	for e in enemies:
		if config.get_value("Save_Enemy", e) == false:
			enemies[e] = false

