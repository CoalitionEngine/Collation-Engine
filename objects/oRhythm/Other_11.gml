///@desc Turn Making
event_inherited();
#region Turn 0
TurnCreate(0,0,1,function(){
	SoulSetMode(SOUL_MODE.GREEN)
	oSoul.ShieldAmount = 2;
	CreateArrows(60, 60, 7, 
	["/", "R", "$1", "ads"], ["ads"], [method(id, function(){global.hp = 1})])
	//with oSoul AddShield()
	Set_BoardPos(320,240,0)
	Set_BoardSize(42,42,42,42,0)
	BGM = audio_create_stream("Music/MusNANA.ogg")
	bgm = audio_play_sound(BGM,1,0)
	{
	var barrages=[
			196,205,224,240,261,270,291,309,323,332,355,363,373,
			382,402,421,431,452,468,480,489,500,519,541,577,614,
			656,689,700,736,753,772,788,809,856,861,866,876,885,
			895,905,916,927,940,946,958,964,977,984,997,1004,1017,
			1024,1037,1044,1056,1063,1076,1083,1095,1102,1109,1116,
			1123,1130,1137,1144,1151,1158,1170,1177,1184,1191,1198,
			1205,1205,1212,1219,1227,1235,1249,1257,1268,1274,1288,
			1295,1311,1317,1332,1338,1352,1357,1372,1376,1393,1397,
			1411,1417,1423,1429,1435,1441,1447,1453,1459,1465,1484,
			1492,
			1501,
			1509,
			1517,
			1525,
			1533,
			1541,
			1549,
			1557,
			1571,
			1587,
			1606,
			1624,
			1643,
			1663,
			1681,
			1706,
			1726,
			1745,
			1766,
			1786,
			1807,
			1848,
			1886,
			1924,
			1963,
			1981,
			1994,
			2011,
			2031,
			2203,
			2223,
			2239,
			2259,
			2279,
			2298,
			2318,
			2336,
			2356,
			2375,
			2395,
			2414,
			2436,
			2477,
			2513,
			2556,
			2594,
			2613,
			2635,
			2656,
			2834,
			2868,
			2901,
			2991,
			3033,
			3054,
			3060,
			3132,
			3168,
			3188,
			3207,
			3228,
			3246,
			3257,
			3277,
			3312,
			3327,
			3335,
			3357,
			3378,
			3432,
			3443,
			3469,
			3489,
			3507,
			3517,
			3537,
			3556,
			3569,
			3577,
			3595,
			3604,
			3614,
			3627,
			3644,
			3666,
			3674,
			3697,
			3713,
			3724,
			3733,
			3743,
			3766,
			3784,
			3819,
			3859,
			3878,
			3891,
			3910,
			3931,
			4100,
			4120,
			4140,
			4148,
			4169,
			4186,
			4197,
			4207,
			4228,
			4237,
			4246,
			4261,
			4275,
			4297,
			4303,
			4325,
			4346,
			4364,
			4397,
			4418,
			4453,
			4493,
			4536,
			4567,
			4576,
			4613,
			4631,
			4643,
			4659,
			4683,
			4733,
			4738,
			4754,
			4759,
			4773,
			4778,
			4794,
			4799,
			4813,
			4818,
			4833,
			4838,
			4853,
			4859,
			4874,
			4880,
			4892,
			4898,
			4904,
			4910,
			4916,
			4923,
			4930,
			4937,
			4944,
			4951,
			4968,
			4975,
			4982,
			4989,
			4996,
			5003,
			5010,
			5017,
			5025,
			5032,
			5049,
			5055,
			5069,
			5075,
			5088,
			5094,
			5109,
			5115,
			5129,
			5136,
			5151,
			5157,
			5169,
			5178,
			5187,
			5196,
			5207,
			5213,
			5219,
			5225,
			5231,
			5237,
			5244,
			5250,
			5257,
			5263,
			5280,
			5286,
			5292,
			5298,
			5304,
			5310,
			5316,
			5322,
			5328,
			5334,
			5340,
			5346,
			5352,
			5358,
			
			1095,
			1102,
			1109,
			1116,
			1123,
			1130,
			1137,
			1144,
			1151,
			1158,
			1170,
			1177,
			1184,
			1191,
			1198,
			1205,
			1212,
			1219,
			1227,
			1235,
			1411,
			1417,
			1423,
			1429,
			1435,
			1441,
			1447,
			1453,
			1459,
			1465,
			1484,
			1492,
			1501,
			1509,
			1517,
			1525,
			1533,
			1541,
			1549,
			1557,
			2049,
			2061,
			2070,
			2080,
			2101,
			2109,
			2117,
			2126,
			2135,
			2147,
			2167,
			2203,
			2223,
			2239,
			2259,
			2279,
			2298,
			2318,
			2336,
			2356,
			2375,
			2395,
			2414,
			2436,
			2477,
			2513,
			2556,
			2594,
			2613,
			2635,
			2656,
			2929,
			2950,
			2972,
			3964,
			3982,
			3998,
			4012,
			4031,
			4051,
			4065,
			4077,
			4100,
			4120,
			4140,
			4148,
			4169,
			4186,
			4197,
			4207,
			4228,
			4237,
			4246,
			4258,
			4275,
			4297,
			4303,
			4325,
			4346,
			4364,
			4892,
			4898,
			4904,
			4910,
			4916,
			4923,
			4930,
			4937,
			4944,
			4951,
			4968,
			4975,
			4982,
			4989,
			4996,
			5003,
			5010,
			5017,
			5025,
			5032,
			5169,
			5178,
			5187,
			5196,
			5207,
			5213,
			5219,
			5225,
			5231,
			5237,
			5244,
			5250,
			5257,
			5263,
			5280,
			5286,
			5292,
			5298,
			5304,
			5310,
			5316,
			5322,
			5328,
			5334,
			5340,
			5346,
			5352,
			5358,
	];
	}
	//array_sort(barrages, true)
	function BarrageCreate(delay, speed, direction,mode=0,color=0){
		delays = delay;
		speeds = [];
		dirs = [];
		modes = [];
		colors = [];
	
		function GSA(spd,dir,mde=0, clr=0) {
			array_push(speeds,spd)
			array_push(dirs,irandom(3))
			array_push(modes,mde)
			array_push(colors,clr)
		}
		for(var i = 0, n = array_length(delays); i < n; ++i)
			GSA(speed, direction,mode,color)
		for(var i = 0, n = array_length(delays); i < n; ++i)
		{
			if ((delays[i] - delays[max(0,i-1)]) < 10) dirs[i] = dirs[max(0,i-1)]
			Bullet_Arrow(delays[i],speeds[i], dirs[i],modes[i], 1)
		}
	}
	//for(var i = 0, n = array_length(barrages); i < n; ++i)
	//BarrageCreate(barrages,6,irandom(3), 0, 1)
	
})
TurnCreate(0, 1, 3440, function() {
	TweenFire(oBoard, EaseInOutSine, TWEEN_MODE_ONCE, 0, 0, 480, "image_angle", 0, -1800)
});
TurnCreate(0, 2, 5450, function() {
	Fader_Fade(0,1,60)
})
TurnCreate(0, 3, 5510, function() {
	game_restart()
})
#endregion
TurnCreate(0, 5, 0, function()
{
	var index = CreateNormalLine(0, 480, 640, 480, 2, c_yellow, 5, 90);
	SetLineProperties(index, SetLineProperty.Duration, 1);
	SetLineProperties(index, SetLineProperty.AlphaFade, 480 / 5);
	SetLineProperties(index, SetLineProperty.FadeProperties, LineEndProperty.FADEOUT);
}
, 10000, 5);