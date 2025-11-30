class_name ModificatorView
extends Control

var hbox: HBoxContainer = HBoxContainer.new()
var newModType: String = ""

var i1: int
var i2: int
var i3: int

var i1_s: String = ""
var i2_s: String = ""
var i3_s: String = ""

var font: Font


func randomlyChooseInterval(type: String) -> int:
	var choice
	if type == "decrease_width" or type == "save_finger":
		var arr = [1, 3, 5, 7, 9]
		choice = arr[randi() % arr.size()]
	if type == "increase_mnX":
		var arr = [0, 2, 4, 6, 8, 10]
		choice = arr[randi() % arr.size()]
	return choice

func randomForAll():
	var choice = randomlyChooseInterval("decrease_width")
	i1 = choice
	choice = choice/2 +1
	i1_s = str(choice)
	choice = randomlyChooseInterval("increase_mnX")
	i2 = choice
	if choice == 0:
		i2_s = str("<-- ") + str(choice)
	elif choice == 10:
		i2_s = str(choice/2) +str(" -->") 
	else:
		choice = (choice-1)/2 +1
		i2_s = str(choice) +str(" <--> ")+ str(choice +1) 
	choice = randomlyChooseInterval("save_finger")
	i3 = choice
	choice = choice / 2 + 1
	i3_s = str(choice)


func _ready():

	hbox.anchor_left = 1.0
	hbox.anchor_top = 1.0
	hbox.anchor_right = 1.0
	hbox.anchor_bottom = 1.0
	hbox.add_theme_constant_override("separation", 20) 
	
	hbox.position = Vector2(720, 300) 
	hbox.size_flags_horizontal = Control.SIZE_FILL
	hbox.size_flags_vertical = Control.SIZE_FILL
	
	add_child(hbox)
	
	var arr = [1, 2, 3]
	var layout_choice = arr[randi() % arr.size()]
	var tex = preload("res://resources/images/paper.png")
	var icon_f = preload("res://resources/images/finger.png")
	var icon_i = preload("res://resources/images/fingers2.png")
	
	var title1 = "Slim Finger"
	var descr1 = "Reduces the width of a finger."
	var title2 = "Point Multiplier"
	var descr2 = "Gain extra points between fingers."
	var title3 = "Finger Shield"
	var descr3 = "Survive one extra hit from the knife."
	randomForAll()
 	
 	
	if layout_choice == 1:
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
		create_card(hbox, title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")
	if layout_choice == 2:
		create_card(hbox,title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
	if layout_choice == 3:
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")
	
	hideButtons()

func create_card(parent: Node, title: String, description: String, finger: String, texture: Texture2D, icon_texture: Texture2D, callback: String):

	var card = Button.new()
	card.z_index = 10
	card.custom_minimum_size = Vector2(160, 220)
	card.size_flags_horizontal = Control.SIZE_FILL
	card.size_flags_vertical = Control.SIZE_FILL
	card.toggle_mode = false
	card.flat = true
	card.clip_contents = true 
	
	parent.add_child(card)
	
	var img = TextureRect.new()
	img.texture = texture
	img.stretch_mode = TextureRect.STRETCH_SCALE
	img.mouse_filter = Control.MOUSE_FILTER_IGNORE
	img.anchor_left = 0.0
	img.anchor_top = 0.0
	img.anchor_right = 1.0
	img.anchor_bottom = 1.0
	img.offset_left = 0
	img.offset_top = 0
	img.offset_right = 0
	img.offset_bottom = 0
	
	card.add_child(img)
	
	var margin = MarginContainer.new()
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.anchor_left = 0.0
	margin.anchor_top = 0.0
	margin.anchor_right = 1.0
	margin.anchor_bottom = 1.0
	margin.offset_left = 0
	margin.offset_top = 0
	margin.offset_right = 0
	margin.offset_bottom = 0
	
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 5)
	
	card.add_child(margin)
	
	var vbox = VBoxContainer.new()
	vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.size_flags_vertical = Control.SIZE_FILL
	vbox.add_theme_constant_override("separation", 2) 
	
	margin.add_child(vbox)
	
	var label = Label.new()
	label.text = title
	label.label_settings = LabelSettings.new()
	label.label_settings.font_size = 20
	label.label_settings.outline_size = 3
	label.label_settings.font_color = Color.RED
	label.label_settings.font = font
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_FILL
	label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	label.clip_text = true
	
	vbox.add_child(label)
	
	var desc_label = Label.new()
	desc_label.text = description
	desc_label.label_settings = LabelSettings.new()
	desc_label.label_settings.font_size = 20
	desc_label.label_settings.font_color = Color.MIDNIGHT_BLUE
	desc_label.label_settings.outline_size = 2
	desc_label.label_settings.font = font
	desc_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	desc_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	desc_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	desc_label.size_flags_horizontal = Control.SIZE_FILL
	desc_label.size_flags_vertical = Control.SIZE_EXPAND_FILL  
	desc_label.clip_text = true
	
	vbox.add_child(desc_label)
	
	var f_label = Label.new()
	f_label.text = finger
	f_label.label_settings = LabelSettings.new()
	f_label.label_settings.font_size = 22
	f_label.label_settings.outline_size = 4
	f_label.label_settings.font_color = Color.BLACK
	f_label.label_settings.font = font
	f_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	f_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	f_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	f_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	f_label.size_flags_horizontal = Control.SIZE_FILL
	f_label.size_flags_vertical = Control.SIZE_EXPAND_FILL  
	f_label.clip_text = true
	
	vbox.add_child(f_label)
	
	var icon_container = MarginContainer.new()
	icon_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_container.size_flags_horizontal = Control.SIZE_FILL
	icon_container.size_flags_vertical = Control.SIZE_SHRINK_END
	icon_container.add_theme_constant_override("margin_left", 5)
	icon_container.add_theme_constant_override("margin_right", 5)
	icon_container.add_theme_constant_override("margin_bottom", 5)
	
	vbox.add_child(icon_container)
	
	var icon = TextureRect.new()
	icon.texture = icon_texture
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.custom_minimum_size = Vector2(50, 50)  # размер иконки
	icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	
	icon_container.add_child(icon)
	
	card.pressed.connect(self.get(callback))


func redraw():
	for child in hbox.get_children():
		child.queue_free()
	
	var arr = [1, 2, 3]
	var layout_choice = arr[randi() % arr.size()]
	var tex = preload("res://resources/images/paper.png")
	var icon_f = preload("res://resources/images/finger.png")
	var icon_i = preload("res://resources/images/fingers2.png")

	var title1 = "Slim Finger"
	var descr1 = "Reduces the width of a finger."

	var title2 = "Point Multiplier"
	var descr2 = "Gain extra points between fingers."

	var title3 = "Finger Shield"
	var descr3 = "Survive one extra hit from the knife."
	
	randomForAll()

	if layout_choice == 1:
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
		create_card(hbox, title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")
	elif layout_choice == 2:
		create_card(hbox, title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
	else:
		create_card(hbox, title3, descr3, i3_s, tex, icon_f, "_on_button3_pressed")
		create_card(hbox, title1, descr1, i1_s, tex, icon_f, "_on_button1_pressed")
		create_card(hbox, title2, descr2, i2_s, tex, icon_i, "_on_button2_pressed")

	
	hideButtons()



func _on_button1_pressed():
	newModType = "decrease_width"
	
func _on_button2_pressed():
	newModType = "increase_mnX"

func _on_button3_pressed():
	newModType = "save_finger"

func showButtons():
	for b in hbox.get_children():
		b.show()

func hideButtons():
	for b in hbox.get_children():
		b.hide()
