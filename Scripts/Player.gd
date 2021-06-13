extends KinematicBody2D

var motion = Vector2();

var turretclass =  load("res://Character/Turret.tscn");
var canShoot=true;
var turretRef = null;
var isTurretInArea = false;
var isCarryingTurret = false;
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
		
	if Input.is_action_just_pressed("ui_action") and isCarryingTurret:
		var current_Node = get_parent().get_child(0);
		var newTurret = turretclass.instance();
		newTurret.position = current_Node.global_position;
		newTurret.name = "Turret"
		get_parent().add_child(newTurret);
		get_parent().get_child(1)._shot_status(true);
		# TODO: Change sprite back when dropping turret
		$Sprite.modulate = Color(1,1,1);
		isCarryingTurret=false;
		
	if Input.is_action_just_pressed("ui_action") and isTurretInArea:
		var tempTurret = turretRef;
		get_parent().remove_child(turretRef);
		### TODO: Change sprite when picking up Turret
		$Sprite.modulate = Color(1,0,0)
		isTurretInArea = false;
		isCarryingTurret = true;
		
	move_and_collide(motion);
	pass;

func _on_Area2D_body_entered(body):
	if(body.get_name()=="Turret") and !isCarryingTurret :
		isTurretInArea = true;
		turretRef=body;
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if(body.get_name()=="Turret"):
		isTurretInArea = false;
		turretRef = null;
	pass # Replace with function body.
