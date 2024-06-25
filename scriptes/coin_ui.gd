extends Node2D


var coin_num = 0

@onready var coin_num_label = $HBoxContainer/HFlowContainer/CoinNum


func _ready():
	SignalBus.player_get_coin.connect(update_coin_num)
	

func update_coin_num():
	coin_num += 1
	coin_num_label.text = str(coin_num)
