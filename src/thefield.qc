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
};

void() tfld_update =
{
	if (time < 3)
		centerprint(tfld_player, "You are on The Field. Fight!\n");
};
