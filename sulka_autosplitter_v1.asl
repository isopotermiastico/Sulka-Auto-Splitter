state("Sulka")
{
	uint room : "Sulka.exe", 0x722248;
	uint minutes: "Sulka.exe", 0x4E364C, 0x4;
        uint milliseconds: "Sulka.exe", 0x4E3624;
	uint tuto_player_exists: "Sulka.exe", 0x469D20, 0x2A0, 0x10, 0x90, 0x2C, 0x40;
}
init
{
	print("INIT");
}
startup
{
	print("STARTUP");
	vars.is_timer_running = false;
	vars.has_run_ended = false;
	vars.n = 2;
	vars.room_changed = false;
}
update
{	
	if (old.milliseconds != current.milliseconds)
	{
		vars.is_timer_running = true;
		vars.n = 2;
	}
	else 
	{
		vars.n -= 1;
	}
	if (vars.n == 0)
	{
		vars.is_timer_running = false;
	}
	if (current.room == 2 && vars.is_timer_running == false)
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
print(current.tuto_player_exists.ToString());
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