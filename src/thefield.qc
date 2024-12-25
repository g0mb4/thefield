/*
 * The Field
 *
 * 2024, Tóth János
 */

// globals
entity tfld_player;
float tfld_wave_ctr;

float TFLD_E_NONE	= 0;
float TFLD_E_DOG	= 1;
float TFLD_E_OGRE	= 2;

// prototypes
void() tfld_precache;
void() tfld_init;
void() tfld_update;

void() tfld_spwan_dog;
void() tfld_spwan_ogre;
void(entity e) tfld_enemy_setup;
void(entity e, float z) tfld_random_position;
void(float type, float num) tfld_spawn_enemies;

void() tfld_precache =
{
	precache_model ("progs/h_dog.mdl");
	precache_model ("progs/dog.mdl");
	precache_sound ("dog/dattack1.wav");
	precache_sound ("dog/ddeath.wav");
	precache_sound ("dog/dpain1.wav");
	precache_sound ("dog/dsight.wav");
	precache_sound ("dog/idle.wav");

	precache_model ("progs/ogre.mdl");
	precache_model ("progs/h_ogre.mdl");
	precache_model ("progs/grenade.mdl");
	precache_sound ("ogre/ogdrag.wav");
	precache_sound ("ogre/ogdth.wav");
	precache_sound ("ogre/ogidle.wav");
	precache_sound ("ogre/ogidle2.wav");
	precache_sound ("ogre/ogpain1.wav");
	precache_sound ("ogre/ogsawatk.wav");
	precache_sound ("ogre/ogwake.wav");
};

void() tfld_init =
{
	cvar_set("skill", "2");	// start on hard

	tfld_doublejump_ctr = 2;	// client.qc
	tfld_player.items =  IT_AXE | IT_SUPER_SHOTGUN | IT_SUPER_NAILGUN | IT_ROCKET_LAUNCHER;
	tfld_player.weapon = IT_SUPER_SHOTGUN;
	tfld_player.ammo_shells = 666;
	tfld_player.ammo_nails = 666;
	tfld_player.ammo_rockets = 666;
	tfld_player.currentammo = self.ammo_shells;
	tfld_player.weaponmodel = "progs/v_shot2.mdl";
	tfld_player.weaponframe = 0;
	tfld_player.items = self.items | IT_SHELLS | IT_ROCKETS | IT_NAILS;

	tfld_player.health = 200;
	tfld_player.armorvalue = 200;
	tfld_player.armortype = 0.8;	// ??
	tfld_player.items = self.items | IT_ARMOR3;

	// Fix PR_ExecuteProgram: NULL function
	tfld_player.think = SUB_Null;

	tfld_wave_ctr = 0;
};

void() tfld_update =
{
	if (tfld_player.origin_z < -16) {
		tfld_player.health = -1;
	}

	if (time < 1)
		centerprint(tfld_player, "You are on The Field. Fight!\n");

	if (time > 3 && tfld_wave_ctr == 0) {
		tfld_spawn_enemies (TFLD_E_DOG, 4);
		tfld_wave_ctr = tfld_wave_ctr + 1;
	} else if (time > 5 && tfld_wave_ctr == 1 ) {
		tfld_spawn_enemies (TFLD_E_OGRE, 6);
		tfld_wave_ctr = tfld_wave_ctr + 1;
	}
};

void(float type, float num) tfld_spawn_enemies =
{
	local float n;

	n = 0;

	while (n < num)
	{
		if (type == TFLD_E_DOG)
			tfld_spwan_dog ();
		else if (type == TFLD_E_OGRE)
			tfld_spwan_ogre ();

		n = n + 1;
	}
};

void(entity e, float z) tfld_random_position =
{
	local float spawn_min, spawn_range, spawn_side;
	local vector new_origin, player_origin;

	spawn_min = 100;	// avoid center column
	spawn_range = 300;

	// only check for ther XY plane
	new_origin_z = 0;
	player_origin = tfld_player.origin;
	player_origin_z = 0;

	do
	{
		if (random () < 0.5)
			spawn_side = -1.0;
		else
			spawn_side = 1.0;

		new_origin_x = (random () * spawn_range + spawn_min) * spawn_side;
	
		if (random () < 0.5)
			spawn_side = -1.0;
		else
			spawn_side = 1.0;

		new_origin_y = (random () * spawn_range + spawn_min) * spawn_side;
	}
	while (vlen (player_origin - new_origin) <= 100);

	new_origin_z = z;

	setorigin(e, new_origin);
};

void(entity e) tfld_enemy_setup =
{
	local entity tmp_self;
	
	setsize (e, VEC_HULL2_MIN, VEC_HULL2_MAX);
	
	e.angles = vectoangles (tfld_player.origin - e.origin);
	e.ideal_yaw = vectoyaw (tfld_player.origin - e.origin);
	e.view_ofs = '0 0 25';
	e.solid = SOLID_SLIDEBOX;
	e.movetype = MOVETYPE_STEP;

	e.target = "player";

	spawn_tfog (e.origin);
	spawn_tdeath (e.origin, e);
	e.teleport_time = time + 1;
	
	tmp_self = self;
	self = e;
	
	walkmonster_start();
	
	self = tmp_self;
};

void() tfld_spwan_dog =
{
	local entity dog;

	dog = spawn ();

	tfld_random_position (dog, 50);
	dog.classname = "monster_dog";
	setmodel (dog, "progs/dog.mdl");

	dog.health = 25;
	dog.th_stand = dog_stand1;
	dog.th_walk = dog_walk1;
	dog.th_run = dog_run1;
	dog.th_pain = dog_pain;
	dog.th_die = dog_die;
	dog.th_melee = dog_atta1;
	dog.th_missile = dog_leap1;
	
	tfld_enemy_setup (dog);

	total_monsters = total_monsters + 1;
};

void() tfld_spwan_ogre =
{
	local entity ogre;

	ogre = spawn ();

	tfld_random_position (ogre, 50);
	ogre.classname = "monster_ogre";
	setmodel (ogre, "progs/ogre.mdl");

	ogre.health = 200;
	ogre.th_stand = ogre_stand1;
	ogre.th_walk = ogre_walk1;
	ogre.th_run = ogre_run1;
	ogre.th_die = ogre_die;
	ogre.th_melee = ogre_melee;
	ogre.th_missile = ogre_nail1;
	ogre.th_pain = ogre_pain;
	
	tfld_enemy_setup (ogre);

	total_monsters = total_monsters + 1;
};
