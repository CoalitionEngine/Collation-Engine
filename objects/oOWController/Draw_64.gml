var ItemCount = Item_Count(),
	CellCount = Cell.Count(),
	input_horizontal = PRESS_HORIZONTAL,
	input_cancel = PRESS_CANCEL,
	input_confirm = PRESS_CONFIRM;
draw_set_font(fnt_dt_sans);
#region Save UI
if __save_state >= SAVE_STATE.CHOOSING
{
	__wait_time++;
	oOWPlayer.moveable = false;
	//Box UI drawing, using int over vars are better
	draw_rectangle_width_background(108, 118, 108 + 424, 118 + 174);
	//If saving is finshed, the text will be yellow
	draw_set_color(__save_state == SAVE_STATE.FINISHED ? c_yellow : c_white);
	draw_set_halign(fa_left);
	draw_text(140, 140, Player.Name());
	draw_text(295, 140, string_concat("LV ", Player.LV()));
	var time = global.timer,
		second = time div 60,
		minute = string(second div 60);
	second = string(second % 60);
	//Zeropadding
	second = string_length(second) == 1 ? "0" + second : second;
	draw_text(423, 140, minute + ":" + second);
	draw_text(140, 180, RoomNames[| OverworldSubRoom]);
	if __save_state == SAVE_STATE.CHOOSING
	{
		//Soul alpha sin-ing
		var SoulAlpha = abs(dsin(global.timer)) + 0.3;
		draw_sprite_ext(sprSoul, 0, 151 + __save_choice * 180, 255, 1, 1, 90, c_red, SoulAlpha);
		draw_text(170, 240, "Save");
		draw_text(350, 240, "Return");
	}
	elif __save_state == SAVE_STATE.FINISHED
	{
		draw_set_halign(fa_center);
		draw_text(240, 240, "File Saved.");
	}
}
#endregion
#region Menu Overworld
// Check if the menu should display more on top or more on bottom, depending on player's position
var menu_at_top = oOWPlayer.y < Camera.ViewY() + Camera.ViewHeight() / 2 + 10;
//Don't draw if the box is out of bounds
if menu_ui_x > -140
{
	#region The "Name - LV - HP - G" box
	// Position and side elements
	var ui_box_x = menu_ui_x + 6,
		ui_box_y = menu_at_top ? 45 : 328;
	// Box Drawing
	draw_rectangle_width_background(ui_box_x, ui_box_y, ui_box_x + 130 - 1, ui_box_y + 98 - 1, 5);
	
	// String var declaration
	var lv =		string(Player.LV()),
		hp =		string(Player.HP()),
		max_hp =	string(Player.HPMax());

	// String drawing
	draw_set_color(c_white);
	ui_box_x += 12;
	draw_text(ui_box_x, ui_box_y + 3, Player.Name());


	draw_set_font(fnt_cot);
	draw_text(ui_box_x, ui_box_y + 36, "LV  " + lv);
	draw_text(ui_box_x, ui_box_y + 54, "HP  " + hp + "/" + max_hp);

	// Toby Fox method because the number in Gold is not aligned correctly with spaces
	var ui_num_x = ui_box_x + string_width("LV  ");
	draw_text(ui_box_x, ui_box_y + 72, "G");
	draw_text(ui_num_x, ui_box_y + 72, Player.Gold());
	#endregion
	#region The "ITEM - STAT - CELL" box with their respective elements
	// Position and side elements for the box
	ui_box_x = menu_ui_x + 6;
	
	// Box Drawing
	draw_rectangle_width_background(ui_box_x, 174, ui_box_x + 130 - 1, 174 + 136 - 1);

	// Menu Label
	var exist_check = [ItemCount, 1, CellCount];
	draw_set_font(fnt_dt_sans);
	for (var i = 0; i < 3; ++i)
	{
		// Check if the menu exists or not to proceed color
		draw_set_color(menu_color[i][bool(exist_check[i])]);
		draw_text(ui_box_x + 46, 174 + 15 + i * 36, menu_label[i]);
	}
	draw_set_color(c_white);

	#region Drawing the box for each state
		#region ITEM state
		if menu_ui_y[MENU_MODE.ITEM] > -500
		{
			var ui_box_y = menu_ui_y[MENU_MODE.ITEM] + 6;
			// Box Drawing
			draw_rectangle_width_background(194, ui_box_y, 194 + 334 - 1, ui_box_y + 350 - 1,,,,, 0.8);
	
			// Item text drawing
			var i = 0;
			repeat ItemCount
			{
				draw_text(232, ui_box_y + 23 + i * 32, item_name[i]);
				++i;
			}

			// Item function
			for(var i = 0; i < 3; i++)
				draw_text(i == 0 ? 234 : (i == 1 ? 330 : 444), ui_box_y + 303, menu_item_text[i]);
		}
		#endregion
		#region STAT state
		if menu_ui_y[MENU_MODE.STAT] > -480
		{
			var ui_box_y = menu_ui_y[MENU_MODE.STAT] + 6;
				
			// Box Drawing
			draw_rectangle_width_background(194, ui_box_y, 194 + 334 - 1, ui_box_y + 406 - 1,,,,, 0.8);
	
			// Stat text drawing
			draw_set_font(fnt_dt_sans);
			draw_set_color(c_white);
			draw_text(216, ui_box_y + 27, string_concat("\"", Player.Name(), "\""));
			draw_text(216, ui_box_y + 87, string_concat("LV ", lv));
			draw_text(216, ui_box_y + 119, string_concat("HP ", hp, " / ", max_hp));
			draw_text(216, ui_box_y + 183, string_concat("AT ", global.player_base_atk, " (", global.player_attack, ")"));
			draw_text(216, ui_box_y + 215, string_concat("DF ", global.player_base_def, " (", global.player_def, ")"));
			draw_text(384, ui_box_y + 183, string_concat("EXP: " ,Player.Exp()));
			draw_text(384, ui_box_y + 215, string_concat("NEXT: ", Player.GetExpNext()));
			draw_text(216, ui_box_y + 273, string_concat("WEAPON: ", COALITION_DATA.AttackItem));
			draw_text(216, ui_box_y + 305, string_concat("ARMOR: ", COALITION_DATA.DefenseItem));
			draw_text(216, ui_box_y + 347, string_concat("GOLD: ", Player.Gold()));
		}
		#endregion
		#region CELL state
		if menu_ui_y[MENU_MODE.CELL] > -500
		{
			var ui_box_y = menu_ui_y[MENU_MODE.CELL] + 6;
	
			// Box Drawing
			draw_rectangle_width_background(194, ui_box_y, 194 + 334 - 1, ui_box_y + 258 - 1,,,,, 0.8);
		
			// Cell text drawing
			for (var i = 0; i < CellCount; ++i)
				draw_text(232, ui_box_y + 23 + i * 32, Cell.GetName(i));
		}
		#endregion
	#endregion
	#region Box drawing
	// Check if player has opened a Box
	if __is_using_box
	{
		oOWPlayer.moveable = false;
		//Box UI drawing
		draw_rectangle_width_background(20, 20, 620, 460);
		draw_set_color(c_white);
		draw_line_width(320, 90, 320, 390, 5);
		draw_set_font(fnt_dt_sans);
		draw_set_halign(fa_center);
		//Box Text drawing
		draw_text(170, 35, "INVENTORY");
		draw_text(470, 35, "BOX");
		draw_text(320, 410, "Press [X] to Finish");
		draw_set_halign(fa_left);
		Item_Info_Load();
		//Draw item names
		for (var i = 0; i < ItemCount; ++i)
			draw_text(80, 70 + i * 35, item_name[i]);
		//Draw red lines for empty slots
		for (var i = ItemCount; i < 8; ++i)
			draw_line_width_color(95, 85 + i * 35, 245, 85 + i * 35, 2, c_red, c_red);
		//Item Text / line drawing
		var i = 0;
		repeat 10
		{
			if i < Box.Count(Box_ID)
			{
				Box.InfoLoad();
				draw_text(380, 70 + i * 35, box_name[i]);
			}
			else
				draw_line_width_color(395, 85 + i * 35, 545, 85 + i * 35, 2, c_red, c_red);
			++i;
		}
	}
	#endregion
	// Drawing the soul over everything
	draw_sprite_ext(sprSoulMenu, 0, menu_soul_pos[0], menu_soul_pos[1], 1, 1, 0, c_red, menu_soul_alpha);
	#endregion
}
#endregion
#region Dialog
// Check if a Overworld Dialog is occuring and the screen is not flashed due to encounter animation
if dialog_exists && !(oOWPlayer.encounter_draw & 1)
{
	//Dialog Box drawing
	var dialog_box_y = dialog_is_down ? 320 : 10;
	draw_rectangle_width_background(30, dialog_box_y, 610, dialog_box_y + 150);
	
	//Dialog Text drawing
	var dis = 0;
	//Draws sprite for dialog if the given sprite exists
	if dialog_sprite != noone
	{
		dis = 95;
		var spr_w = sprite_get_width(dialog_sprite),
			spr_h = sprite_get_height(dialog_sprite),
			sprite_dis_x = sprite_get_xoffset(dialog_sprite) - spr_w / 2,
			sprite_dis_y = sprite_get_yoffset(dialog_sprite) - spr_h / 2;
		draw_sprite_ext(dialog_sprite, dialog_sprite_index, 30 + 60 + sprite_dis_x, dialog_box_y + 80 + sprite_dis_y, 80 /spr_w, 80 / spr_h, 0, c_white, 1);
	}
	//Draws dialog texts
	__text_writer.draw(30 + 25 + dis, dialog_box_y + 20, __dialog_typist);
	
	//Check if the dialog is currently an option and draw if question is asked and buffer time has expired
	if dialog_option && __dialog_typist.get_state() == 1 && !option_buffer
		draw_sprite_ext(sprSoul, 0, 36 + dis + __option_pos[# option, 0], dialog_box_y + 20 + __option_pos[# option, 1], 1, 1, 90, c_red, 1);
}
#endregion
#region Debugger
DrawDebugUI();
#endregion