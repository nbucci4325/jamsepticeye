extends Node
class_name State

#think of this script as an interface

signal Transitioned

func Enter(): #when it's this state's turn, start
	pass

func Exit():# when this state's turn is over, end
	pass

func Update(_delta: float): # affects the process
	pass

func Physics_Update(_delta: float): # affects the physics process
	pass
