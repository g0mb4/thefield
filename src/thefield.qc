/*
 * The Field
 *
 * 2024, Tóth János
 */

// globals
entity	tfld_player;
float tfld_wave_ctr;

// prototypes
void() tfld_precache;
void() tfld_init;
void() tfld_update;
void() tfld_spwan_dog;
void(entity e, float z) tfld_random_position;
void(entity e) tfld_walkmonster_start;

void() tfld_precache = {
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
		tfld_spwan_dog ();
		tfld_wave_ctr = tfld_wave_ctr + 1;

		dprint ("Wave ");
		dprint (ftos(tfld_wave_ctr));
		dprint (" started\n");
	}

};

void(entity e, float z) tfld_random_position = {
	// TODO(gmb): Use random position.
	e.origin_x = 100;
	e.origin_y = 0;
	e.origin_z = z;
};

void(entity e) tfld_walkmonster_start = {
	e.nextthink = e.nextthink + 1;
	e.think = walkmonster_start_go;

	total_monsters = total_monsters + 1;
};

void() tfld_spwan_dog = {
	local entity dog;

	dog = spawn();

	dog.solid = SOLID_SLIDEBOX;
	dog.movetype = MOVETYPE_STEP;

	setmodel (dog, "progs/dog.mdl");

	setsize (dog, '-32 -32 -24', '32 32 40');
	dog.health = 25;

	dog.th_stand = dog_stand1;
	dog.th_walk = dog_walk1;
	dog.th_run = dog_run1;
	dog.th_pain = dog_pain;
	dog.th_die = dog_die;
	dog.th_melee = dog_atta1;
	dog.th_missile = dog_leap1;

	// TODO(gmb): Make the dog angry
	dog.enemy = tfld_player;

	tfld_random_position (dog, 20);
	tfld_walkmonster_start (dog);
};
