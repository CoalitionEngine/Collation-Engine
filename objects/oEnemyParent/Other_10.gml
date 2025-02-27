///@desc Enemy Drawing
//Wiggling
var E_Sprites = array_length(enemy_sprites),
	wiggle_method = enemy_sprite_wiggle,
	FinalPosition = [0, 0], FinalSprites = [], FinalIndex = [];
//This must be done to prevent slamming sprites to override the default sprites
array_copy(FinalSprites, 0, enemy_sprites, 0, E_Sprites);
array_copy(FinalIndex, 0, enemy_sprite_index, 0, E_Sprites);

//Slamming
if SlammingEnabled
{
	if Slamming {
		var _slam_dir = SlamDirection / 90;
		if SlamTimer++
		{
			FinalSprites[SlamSpriteNumber] = SlamSprites[_slam_dir][SlamSpriteIndex];
			if SlamTimer < 25
				FinalIndex[SlamSpriteNumber] = SlamSpriteTargetIndex[_slam_dir][SlamTimer / 5];	
			if SlamTimer == 25 Slamming = false;
		}
	}
	else
	{
		SlamTimer = 0;
		array_copy(FinalSprites, 0, enemy_sprites, 0, E_Sprites);
		array_copy(FinalIndex, 0, enemy_sprite_index, 0, E_Sprites);
	}
}

//Draws the enemy sprites (Engine functions)
for (var i = 0; i < E_Sprites; ++i) {
	if string_width(enemy_sprite_draw_method[i]) == 0
	{
		draw_sprite_ext(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0],
			y + enemy_sprite_pos[i][1],
			enemy_sprite_scale[i][0], enemy_sprite_scale[i][1],
			0, c_white, image_alpha);
		break;
	}
	__CoalitionEngineError(array_length(wiggle_method[i]) < 5, "Amount of arguments supplied in the array 'enemy_sprite_wiggle' on the ", i, "th dimension is incorrect, expected 5 got ", array_length(enemy_sprite_pos[i]));
	if wiggle_method[i][0] == "sin"
		FinalPosition = [
				sin(__wiggle_timer * wiggle_method[i][1]) * wiggle_method[i][3],
				sin(__wiggle_timer * wiggle_method[i][2]) * wiggle_method[i][4]
			];
	else if wiggle_method[i][0] == "cos"
		FinalPosition = [
				cos(__wiggle_timer * wiggle_method[i][1]) * wiggle_method[i][3],
				cos(__wiggle_timer * wiggle_method[i][2]) * wiggle_method[i][4]
			];
	if enemy_sprite_draw_method[i] == "ext"
		draw_sprite_ext(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0] + FinalPosition[0],
			y + enemy_sprite_pos[i][1] + FinalPosition[1],
			enemy_sprite_scale[i][0], enemy_sprite_scale[i][1],
			0, c_white, image_alpha);
	else if enemy_sprite_draw_method[i] == "pos"
	{
		__CoalitionEngineError(array_length(enemy_sprite_pos[i]) < 8, "Amount of arguments supplied in the array 'enemy_sprite_pos' on the ", i, "th dimension is incorrect, expected 8 got ", array_length(enemy_sprite_pos[i]));
		draw_sprite_pos(FinalSprites[i], FinalIndex[i],
			x + enemy_sprite_pos[i][0] + FinalPosition[0],
			y + enemy_sprite_pos[i][1] + FinalPosition[1],
			x + enemy_sprite_pos[i][2] + FinalPosition[0],
			y + enemy_sprite_pos[i][3] + FinalPosition[1],
			x + enemy_sprite_pos[i][4],
			y + enemy_sprite_pos[i][5],
			x + enemy_sprite_pos[i][6],
			y + enemy_sprite_pos[i][7],
			image_alpha);
	}
}


//Don't delete, this prevents the enemy draw inside the board
Battle_Masking_Start(true);
draw_sprite_ext(sprPixel, 0, x - enemy_max_width / 2, y - enemy_total_height, enemy_max_width, enemy_total_height, 0, c_black, 1);
Battle_Masking_End();