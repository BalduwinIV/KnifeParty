class_name ModificatorView
extends Control

var hbox: HBoxContainer = HBoxContainer.new()

func _ready():
	# Anchors: правый нижний угол
	hbox.anchor_left = 1.0
	hbox.anchor_top = 1.0
	hbox.anchor_right = 1.0
	hbox.anchor_bottom = 1.0

	# Позиция относительно нижнего правого угла
	hbox.position = Vector2(820, 300)  # сдвиг влево и вверх
	hbox.size_flags_horizontal = Control.SIZE_FILL
	hbox.size_flags_vertical = Control.SIZE_FILL
	
	add_child(hbox)
	
	var arr = [1, 2, 3]
	var choice = arr[randi() % arr.size()]
	var tex = preload("res://resources/images/paper.png") #
 	
	if choice == 1:
		create_card(hbox, "increase_pnX", tex, "_on_button1_pressed")
		create_card(hbox, "increase_mnX", tex, "_on_button2_pressed")
		create_card(hbox, "save_finger", tex, "_on_button3_pressed")
	if choice == 2:
		create_card(hbox, "increase_pnX", tex, "_on_button1_pressed")
		create_card(hbox, "increase_mnX", tex, "_on_button2_pressed")
		create_card(hbox, "save_finger", tex, "_on_button3_pressed")
	if choice == 3:
		create_card(hbox, "increase_pnX", tex, "_on_button1_pressed")
		create_card(hbox, "increase_mnX", tex, "_on_button2_pressed")
		create_card(hbox, "save_finger", tex, "_on_button3_pressed")
		
	
	hideButtons()  # сразу скрываем кнопки

func create_card(parent: Node, text: String, texture: Texture2D, callback: String):

	var card = Button.new()
	card.custom_minimum_size = Vector2(100, 150) # размер карточки
	card.toggle_mode = false
	parent.add_child(card)

	# Стилизация
	card.add_theme_color_override("font_color", Color.WHITE)
	card.add_theme_color_override("bg_color", Color.GRAY)
	
	# Вставляем картинку
	var img = TextureRect.new()
	img.texture = texture
	img.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	img.size_flags_vertical = Control.SIZE_EXPAND_FILL
	img.size_flags_horizontal = Control.SIZE_FILL
	card.add_child(img)
	# Подпись
	var label = Label.new()
	label.text = text
	label.add_theme_color_override("font_color", Color.NAVY_BLUE)
	label.horizontal_alignment = Label.PRESET_CENTER # ✅ Godot 4   # если нужно по вертикал
	label.size_flags_vertical = Control.SIZE_FILL
	label.size_flags_horizontal = Control.SIZE_FILL
	card.add_child(label)
	
	# Подключаем клик
	card.pressed.connect(self.get(callback))



	
# Обработчики кнопок
func _on_button1_pressed() -> ModificatorData:
	var arr = [0, 2, 4, 6, 8, 10]
	var choice = arr[randi() % arr.size()]
	var mod = ModificatorData.new("increase_pnX")
	return mod
	

func _on_button2_pressed() -> ModificatorData:
	var arr = [0, 2, 4, 6, 8, 10]
	var choice = arr[randi() % arr.size()]
	var mod = ModificatorData.new("increase_mnX")
	return mod

func _on_button3_pressed() -> ModificatorData:
	var arr = [0, 2, 4, 6, 8, 10]
	var choice = arr[randi() % arr.size()]
	var mod = ModificatorData.new("save_finger")
	return mod


func showButtons():
	for b in hbox.get_children():
		b.show()

func hideButtons():
	for b in hbox.get_children():
		b.hide()
