extends KinematicBody2D

var motion = Vector2();

var turrentclass =  preload("res://Scripts/Turret.gd");
var dash = false;
var destination;
var dash_frames = 0
var recoil_dash = Vector2();
var dash_velocity= Vector2();
var canShoot=true;
var canDash=true;
var TurretArea = false;
var Turret = null;
var carryTurret = false;
var speed=5;
func _ready():
	
	pass # Replace with function body.
	
	
func _process(delta):
	motion=Vector2.ZERO;
	
	if Input.is_action_pressed("ui_right"):
		motion.x=speed;
	if Input.is_action_pressed("ui_left"):
		motion.x=-speed;
	if Input.is_action_pressed("ui_up"):
		motion.y=-speed;
	if Input.is_action_pressed("ui_down"):
		motion.y=speed;
		
	if Input.is_action_just_pressed("ui_action") and carryTurret:
		var current_Node = get_parent().get_child(0);
		var turrent = current_Node.get_child(current_Node.get_child_count()-1);
		var temp = turrent;
		temp.position = current_Node.global_position;
		current_Node.remove_child(turrent)
		get_parent().add_child(temp);
		get_parent().get_child(1)._shot_status(true);
		carryTurret=false;
		
	if Input.is_action_just_pressed("ui_action") and TurretArea:
		var tempTurrent = Turret;
		#this will be change for a new sprite or animation;
		tempTurrent.position = Vector2(70,70);
		get_parent().remove_child(Turret);
		get_parent().get_child(0).add_child(tempTurrent);
		get_parent().get_child(0).get_child(get_parent().get_child(0).get_child_count()-1)._shot_status(false);
		TurretArea = false;
		carryTurret = true;
	move_and_collide(motion);
	pass;

func _on_Area2D_body_entered(body):
	if(body.get_name()=="Turret") and !carryTurret :
		TurretArea = true;
		Turret=body;
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if(body.get_name()=="Turret"):
		TurretArea = false;
		Turret = null;
	pass # Replace with function body.
