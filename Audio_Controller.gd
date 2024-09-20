extends Node
@onready var bgm = $BGM
@onready var jump = $Jump
@onready var damage = $Damage
@onready var descent = $Descent
@onready var landing = $Landing
@onready var explosion = $Explosion
@onready var door = $Door



# Called when the node enters the scene tree for the first time.
func _ready():
	bgm.play()
