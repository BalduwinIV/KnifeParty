class_name ModificatorView
extends Control

var hbox: HBoxContainer = HBoxContainer.new()
var newModType: String = ""

func _ready():
	# Anchors: правый нижний угол
	hbox.anchor_left = 1.0
	hbox.anchor_top = 1.0
	hbox.anchor_right = 1.0
	hbox.anchor_bottom = 1.0
	hbox.add_theme_constant_override("separation", 30) 
	# Позиция относительно нижнего правого угла
	hbox.position = Vector2(720, 300)  # сдвиг влево и вверх
	hbox.size_flags_horizontal = Control.SIZE_FILL
	hbox.size_flags_vertical = Control.SIZE_FILL
	
	add_child(hbox)
	
	var arr = [1, 2, 3]
	var choice = arr[randi() % arr.size()]
	var tex = preload("res://resources/images/paper.png")
	var icon_f = preload("res://resources/images/finger.png")
	var icon_i = preload("res://resources/images/fly.png")
 	
 	
	if choice == 1:
		create_card(hbox, "Decrease Width", tex, icon_f, "_on_button1_pressed")
		create_card(hbox, "Save Finger", tex, icon_f, "_on_button3_pressed")
		create_card(hbox, "Increase X", tex, icon_i, "_on_button2_pressed")
	if choice == 2:
		create_card(hbox, "Increase X", tex, icon_i, "_on_button2_pressed")
		create_card(hbox, "Decrease Width", tex, icon_f, "_on_button1_pressed")
		create_card(hbox, "Save Finger", tex, icon_f, "_on_button3_pressed")
	if choice == 3:
		create_card(hbox, "Save Finger", tex, icon_f, "_on_button3_pressed")
		create_card(hbox, "Decrease Width", tex, icon_f, "_on_button1_pressed")
		create_card(hbox, "Increase X", tex, icon_i, "_on_button2_pressed")
	
	hideButtons()

func create_card(parent: Node, text: String, texture: Texture2D, icon_texture: Texture2D, callback: String):
	# Создаем кнопку (карточку)
	var card = Button.new()
	card.custom_minimum_size = Vector2(140, 200)
	card.size_flags_horizontal = Control.SIZE_FILL
	card.size_flags_vertical = Control.SIZE_FILL
	card.toggle_mode = false
	card.flat = true
	card.clip_contents = true  # ВАЖНО: обрезает всё за границами кнопки
	
	parent.add_child(card)
	
	# Фоновая картинка растягивается на всю кнопку
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
	
	# MarginContainer для отступов внутри кнопки
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
	
	# Устанавливаем отступы
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 10)
	
	card.add_child(margin)
	
	# Контейнер для вертикального размещения (текст + иконка)
	var vbox = VBoxContainer.new()
	vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.size_flags_horizontal = Control.SIZE_FILL
	vbox.size_flags_vertical = Control.SIZE_FILL
	vbox.add_theme_constant_override("separation", 10)  # расстояние между элементами
	
	margin.add_child(vbox)
	
	# Текст вверху
	var label = Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.add_theme_color_override("font_color", Color.NAVY_BLUE)
	#label.add_theme_font_size_override("font_size", 16)
	#label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.size_flags_horizontal = Control.SIZE_FILL
	label.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	label.clip_text = true  # обрезает текст если он выходит за границы
	
	vbox.add_child(label)
	
	# Разделитель (растягивается, чтобы иконка была внизу)
	var spacer = Control.new()
	spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL
	spacer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	vbox.add_child(spacer)
	
	# Контейнер для иконки с отступами
	var icon_container = MarginContainer.new()
	icon_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon_container.size_flags_horizontal = Control.SIZE_FILL
	icon_container.size_flags_vertical = Control.SIZE_SHRINK_END
	icon_container.add_theme_constant_override("margin_left", 10)
	icon_container.add_theme_constant_override("margin_right", 10)
	icon_container.add_theme_constant_override("margin_bottom", 5)
	
	vbox.add_child(icon_container)
	
	# Иконка внизу
	var icon = TextureRect.new()
	icon.texture = icon_texture
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.custom_minimum_size = Vector2(50, 50)  # размер иконки
	icon.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	icon.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL  # масштабирует с сохранением пропорций
	
	icon_container.add_child(icon)
	
	# Подключаем клик
	card.pressed.connect(self.get(callback))

# Обработчики кнопок
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
