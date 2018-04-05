extends Control

# NOTE: The code here is not explained in the tutorial!
#		This is because it does not really relate to making a FPS.

var start_menu
var level_select_menu
var options_menu

export (String, FILE) var testing_area_scene
export (String, FILE) var test_level_scene
export (String, FILE) var bonus_level_scene


func _ready():
	start_menu = $Start_Menu
	level_select_menu = $Level_Select_Menu
	options_menu = $Options_Menu
	
	# Connect all of the start menu buttons
	$Start_Menu/Button_Start.connect("pressed", self, "start_menu_button_pressed", ["start"])
	$Start_Menu/Button_Open_Godot.connect("pressed", self, "start_menu_button_pressed", ["open_godot"])
	$Start_Menu/Button_Options.connect("pressed", self, "start_menu_button_pressed", ["options"])
	$Start_Menu/Button_Quit.connect("pressed", self, "start_menu_button_pressed", ["quit"])
	
	# Connect all of the level select menu buttons
	$Level_Select_Menu/Button_Back.connect("pressed", self, "level_select_menu_button_pressed", ["back"])
	$Level_Select_Menu/Button_Level_Testing_Area.connect("pressed", self, "level_select_menu_button_pressed", ["testing_scene"])
	$Level_Select_Menu/Button_Level_Test_Level.connect("pressed", self, "level_select_menu_button_pressed", ["test_level"])
	$Level_Select_Menu/Button_Level_Bonus_Level.connect("pressed", self, "level_select_menu_button_pressed", ["bonus_level"])
	
	# Connect all of the options menu buttons
	$Options_Menu/Button_Back.connect("pressed", self, "options_menu_button_pressed", ["back"])
	$Options_Menu/Button_Fullscreen.connect("pressed", self, "options_menu_button_pressed", ["fullscreen"])
	$Options_Menu/Check_Button_VSync.connect("pressed", self, "options_menu_button_pressed", ["vsync"])
	$Options_Menu/Check_Button_Debug.connect("pressed", self, "options_menu_button_pressed", ["debug"])
	
	# Some times when returning to the title screen the mouse is still captured even though it shouldn't be.
	# To prevent this from breaking the game, we just set it here too
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func start_menu_button_pressed(button_name):
	if button_name == "start":
		level_select_menu.visible = true
		start_menu.visible = false
	elif button_name == "open_godot":
		OS.shell_open("https://godotengine.org/")
	elif button_name == "options":
		options_menu.visible = true
		start_menu.visible = false
	elif button_name == "quit":
		get_tree().quit()


func level_select_menu_button_pressed(button_name):
	if button_name == "back":
		start_menu.visible = true
		level_select_menu.visible = false
	elif button_name == "testing_scene":
		get_node("/root/Globals").load_new_scene(testing_area_scene)
	elif button_name == "test_level":
		get_node("/root/Globals").load_new_scene(test_level_scene)
	elif button_name == "bonus_level":
		get_node("/root/Globals").load_new_scene(bonus_level_scene)


func options_menu_button_pressed(button_name):
	if button_name == "back":
		start_menu.visible = true
		options_menu.visible = false
	elif button_name == "fullscreen":
		OS.window_fullscreen = !OS.window_fullscreen
	elif button_name == "vsync":
		OS.vsync_enabled = $Options_Menu/Check_Button_VSync.pressed
	elif button_name == "debug":
		get_node("/root/Globals").set_debug_display($Options_Menu/Check_Button_Debug.pressed)
