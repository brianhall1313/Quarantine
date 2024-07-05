extends Node
@onready var bgm = $BGM
@onready var jump = $Jump
@onready var damage = $Damage
@onready var key_pickup = $Key_Pickup
@onready var descent = $Descent
@onready var landing = $Landing


# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
