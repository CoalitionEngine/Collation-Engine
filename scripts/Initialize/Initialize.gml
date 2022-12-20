function Initialize()
{
	randomize();

	global.player_attack_boost = 0;
	global.player_def_boost = 0;
	global.player_inv_boost = 0;
	global.kr = 0;
	global.kr_activation = false;
	global.damage = 1;
	global.krdamage = 1;
	global.bar_count = 1;
	global.last_dmg_time = 0;
	global.spd = 2; // Speed
	global.inv = 2; // Invincibility frames
	global.EnableGrazing = false;
	global.TP = 0;
	global.item_heal_override_kr = true; //Does kr reduce when max heal or not
	for(var i = 0; i <= ITEM_COUNT; ++i)
		global.item_uses_left[i] = 1;
	global.item_uses_left[ITEM.PIE] = 2;
	global.SpareTextColor = (!irandom(100) ? "[c_fuchsia]" : "[c_yellow]");
	global.BossFight = false;
	
	global.SaveFile = ds_map_create();
	global.SaveFile[? "Name"] =			"Chara";
	global.SaveFile[? "LV"] =			20;
	global.SaveFile[? "HP"] =			99;
	global.SaveFile[? "Max HP"] =		99;
	global.SaveFile[? "Gold"] =			0;
	global.SaveFile[? "EXP"] =			0;
	global.SaveFile[? "Wep"] =			"Stick";
	global.SaveFile[? "Arm"] =			"Bandage";
	global.SaveFile[? "Kills"] =		0;
	var Item_Preset = [ITEM.PIE, ITEM.INOODLES, ITEM.STEAK, ITEM.SNOWP, ITEM.SNOWP, ITEM.LHERO, ITEM.LHERO, ITEM.SEATEA],
		Cell_Preset = [1, 2, 0, 0, 0, 0, 0, 0],
		Box_Preset =  //Insert the items
		[
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// OW Box
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],		// Dimensional Box A
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]		// Dimensional Box B
		];
	for (var i = 0; i < 8; i++) {
		if i < 3
			for (var ii = 0; ii < 8; ii++)
				global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
		global.SaveFile[? ("Cell "+string(i))] = Cell_Preset[i];
		global.SaveFile[? ("Item "+string(i))] = Item_Preset[i];
	}
	
	
	if !file_exists("Data.dat") Save_Datas(); else Load_Datas();
	
	
	global.hp =			global.SaveFile[? "HP"];
	global.hp_max =		global.SaveFile[? "Max HP"];
	global.data =
	{
		name :			global.SaveFile[? "Name"],
		lv :			global.SaveFile[? "LV"],
		Gold :			global.SaveFile[? "Gold"],
		Exp :			global.SaveFile[? "EXP"],
		AttackItem :	global.SaveFile[? "Wep"],
		DefenseItem :	global.SaveFile[? "Arm"],
		Kills :			global.SaveFile[? "Kills"],
	}
	ConvertItemNameToStat();
	Player_GetBaseStats();
	
	for (var i = 0; i < 10; i++) {
		for (var ii = 0; ii < 3; ii++)
			global.Box[ii, i] = global.SaveFile[? "Box "+string(i) + "_" + string(ii)];
		if i < 8
		{
			global.item[i] = global.SaveFile[? ("Item "+string(i))];
			global.cell[i] = global.SaveFile[? ("Cell "+string(i))];
		}
	}
	
	global.Settings = ds_map_create();
	global.Volume = 100;
	
	if !file_exists("Settings.dat") Save_Settings(); else Load_Settings();
	
	global.battle_encounter = 0;
	
	global.text_face = 0;
	global.text_emotion = 0;
	
	//Particles
	global.TrailS = part_system_create();
	global.TrailP = part_type_create();
	part_type_life(global.TrailP, 30, 30);
	part_type_alpha2(global.TrailP, 1, 0);
}