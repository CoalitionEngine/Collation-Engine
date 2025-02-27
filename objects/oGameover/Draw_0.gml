//draw_sprite_ext(sprGameOver,0,320,124,1,1,0,c_white,alpha);
draw_text_transformed_color(320, 124, "GAME\nOVER", 2, 2, 0, c_white, c_white, c_white, c_white, alpha);
if state == 0
	draw_self();

else if state == 2
{
	if alpha < 1 alpha += 0.01;
	if alpha == 1
	{
		gameover_writer.starting_format("fnt_dt_mono",c_white).draw(165, 300, gameover_typist);
		
		if gameover_typist.get_paused() gameover_typist.unpause();

		if gameover_typist.get_state() == 1 && PRESS_CONFIRM &&
		   gameover_writer.get_page() < (gameover_writer.get_page_count() - 1)
			gameover_writer.page(gameover_writer.get_page() + 1);
		else if PRESS_CONFIRM && 
				gameover_typist.get_state() == 1 && 
				gameover_writer.get_page() >= (gameover_writer.get_page_count() - 1)
		{
			state++;
			audio_sound_gain(bgm, 0, 2800);
		}
	}
}
