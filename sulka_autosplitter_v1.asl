state("Sulka")
{
	uint room : "Sulka.exe", 0x722248;
	uint tuto_player_exists: "Sulka.exe", 0x469D20, 0x2A0, 0x10, 0x90, 0x2C, 0x40;
	uint player_exists: "Sulka.exe", 0x469EB8, 0x51C, 0x50, 0xA8, 0x0, 0x180, 0x3C, 0x40;
}
init
{
	print("INIT");
}
startup
{
	print("STARTUP");
	vars.has_run_ended = false;
	vars.room_changed = false;
}
update
{	
	if (current.room == 2 && current.player_exists == 0)
	{
		vars.has_run_ended = true;
	}
	else
	{
		vars.has_run_ended = false;
	}
	if (current.room != old.room && current.room != 6 && current.room != 9 && current.room != 12 && current.room != 16 && current.room != 28)
	{
		vars.room_changed = true;
	}
	else
	{
		vars.room_changed = false;
	}
}

start
{	
	return current.tuto_player_exists == 0 && current.room == 4;
}
split
{
	if (vars.room_changed || vars.has_run_ended)
	{
		return true;
	}
}
reset
{
	return current.tuto_player_exists == 1 && current.room == 4;
}
