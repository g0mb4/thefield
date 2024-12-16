/*
 * The Field
 *
 * 2024, Tóth János
 */

// globals
entity	tfld_player;
float tfld_wave_ctr;

float TFLD_E_NONE	= 0;
float TFLD_E_DOG	= 1;

// prototypes
void() tfld_precache;
void() tfld_init;
void() tfld_update;

void() tfld_spwan_dog;
void(entity e, float z) tfld_random_position;
void(float type, float num) tfld_spawn_enemies;

void() tfld_precache =
{
	// dog
	precache_model ("progs/h_dog.mdl");
	precache_model ("progs/dog.mdl");
	precache_sound ("dog/dattack1.wav");
	precache_sound ("dog/ddeath.wav");
	precache_sound ("dog/dpain1.wav");
	precache_sound ("dog/dsight.wav");
	precache_sound ("dog/idle.wav");

};

void() tfld_init =
{
	tfld_doublejump_ctr = 2;
	tfld_player.items = IT_SUPER_SHOTGUN | IT_AXE;
	tfld_player.weapon = IT_SUPER_SHOTGUN;
	tfld_player.ammo_shells = 25;
	tfld_player.currentammo = self.ammo_shells;
	tfld_player.weaponmodel = "progs/v_shot2.mdl";
	tfld_player.weaponframe = 0;
	tfld_player.items = self.items | IT_SHELLS;

	tfld_wave_ctr = 0;
};

void() tfld_update =
{
	if (time < 3)
		centerprint(tfld_player, "You are on The Field. Fight!\n");

	if (time > 3 && tfld_wave_ctr == 0) {
		tfld_spawn_enemies (TFLD_E_DOG, 4);
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

		n = n + 1;
	}
};

void(entity e, float z) tfld_random_position =
{
	local float spawn_min, spawn_range, spawn_side;
	local vector new_pos;

	spawn_min = 100;	// avoid center column
	spawn_range = 300;
	new_pos_z = z;

	if (random () < 0.5)
		spawn_side = -1.0;
	else
		spawn_side = 1.0;

	new_pos_x = (random () * spawn_range + spawn_min) * spawn_side;
	
	if (random () < 0.5)
		spawn_side = -1.0;
	else
		spawn_side = 1.0;

	new_pos_y = (random () * spawn_range + spawn_min) * spawn_side;
	
	while (vlen (tfld_player.origin - new_pos) <= 100) {
		if (random () < 0.5)
			spawn_side = -1.0;
		else
			spawn_side = 1.0;

		new_pos_x = (random () * spawn_range + spawn_min) * spawn_side;
	
		if (random () < 0.5)
			spawn_side = -1.0;
		else
			spawn_side = 1.0;

		new_pos_y = (random () * spawn_range + spawn_min) * spawn_side;
	}

	e.origin = new_pos;
};

void() tfld_spwan_dog =
{
	local entity dog;

	dog = spawn ();

	dog.classname = "monster_dog";
	tfld_random_position (dog, 30);

	self.flags = self.flags | FL_MONSTER;
	dog.angles = vectoangles (tfld_player.origin - dog.origin);
	dog.ideal_yaw = vectoyaw (tfld_player.origin - dog.origin);
	dog.view_ofs = '0 0 25';
	dog.solid = SOLID_SLIDEBOX;
	dog.movetype = MOVETYPE_STEP;
	dog.flags = FL_MONSTER;
	dog.takedamage = DAMAGE_AIM;
	setmodel (dog, "progs/dog.mdl");

	setsize (dog, '-32 -32 -24', '32 32 40');
	dog.health = 25;

	dog.use = monster_use;
	dog.th_stand = dog_stand1;
	dog.th_walk = dog_walk1;
	dog.th_run = dog_run1;
	dog.th_pain = dog_pain;
	dog.th_die = dog_die;
	dog.th_melee = dog_atta1;
	dog.th_missile = dog_leap1;

	dog.goalentity = dog.movetarget = dog.enemy = tfld_player;
	dog.think = FoundTarget;
	dog.nextthink = time + 0.1;

	total_monsters = total_monsters + 1;
};
