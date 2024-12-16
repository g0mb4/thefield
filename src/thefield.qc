/*
 * The Field
 *
 * 2024, Tóth János
 */

// globals
entity	tfld_player;

// prototypes
void() tfld_init;
void() tfld_update;

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
};

void() tfld_update =
{
	if (time < 3)
		centerprint(tfld_player, "You are on The Field. Fight!\n");


};
