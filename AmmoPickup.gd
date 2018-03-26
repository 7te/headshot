tool
extends Spatial

export (int, "full size", "small") var kit_size = 0 setget kit_size_change

# How many clips does the pickup contain
# 0 = full size, 1 = small
const AMMO_AMOUNTS = [4, 1];

const RESPAWN_TIME = 20;
var respawn_timer = 0;

var is_ready = false;

func _ready():
	
	# If we are in the editor, then return;
	if (Engine.editor_hint == true):
		return;
	
	get_node("Holder/AmmoPickupTrigger").connect("body_entered", self, "trigger_body_entered");
	set_physics_process(true);
	
	is_ready = true;
	
	# Hide all of them
	kit_size_change_values(0, false);
	kit_size_change_values(1, false);
	# Then make only the proper one visible
	kit_size_change_values(kit_size, true);


func _physics_process(delta):
	# If we are in the editor, then simply return
	if (Engine.editor_hint == true):
		return;
	
	if (respawn_timer > 0):
		respawn_timer -= delta;
		if (respawn_timer <= 0):
			kit_size_change_values(kit_size, true);


func kit_size_change(value):
	if (Engine.editor_hint == false):
		if (is_ready == true):
			kit_size_change_values(kit_size, false)
			kit_size = value;
			kit_size_change_values(kit_size, true)
		else:
			kit_size = value;
	else:
		kit_size_change_values(kit_size, false)
		kit_size = value;
		kit_size_change_values(kit_size, true)


func kit_size_change_values(size, enable):
	if (size == 0):
		get_node("Holder/AmmoPickupTrigger/ShapeKit").disabled = !enable;
		get_node("Holder/AmmoKit").visible = enable;
	elif (size == 1):
		get_node("Holder/AmmoPickupTrigger/ShapeKitSmall").disabled = !enable;
		get_node("Holder/AmmoKitSmall").visible = enable;


func trigger_body_entered(body):
	if (body.has_method("add_ammo")):
		body.add_ammo(AMMO_AMOUNTS[kit_size]);
		respawn_timer = RESPAWN_TIME;
		kit_size_change_values(kit_size, false);